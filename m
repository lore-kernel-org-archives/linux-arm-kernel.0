Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD44C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62A720685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UXZ3W47c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEylvC1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62A720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRShPn6KwnDqXlijSlckUikzPb1UsSOrex8NLqeIODw=; b=UXZ3W47chcITKa
	23VSAASb1gbKzw3oBW09OnhH1cQukTbfL9S0MEQzuPhtg7sFt49t67nW65qZXwQGlxGuNkLgLlU+h
	wysDQykJ5rNKuE0waFznBiiS8kWaz3haWJ7Bzzov6iKLhk/ZzZsl85Zi6F41PGbMDgoXKkxtIRBP8
	NzkbLllZt6ko9JQ+RfTmBzSW8iavB/JXnJBHd+EOjtxzd1jRVdr1UdYvdI5J3rEFkE5VIn+toUzgG
	fxzeyDSfBr9bn34WxODH6vPUdMwOz49BBtoSDjkTqU0d3Alo+decguRLQvMJoDS0JIWTiTFKMyPR4
	I8zbSrLB1OZQESLssIhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhKQ-0001w9-SJ; Thu, 10 Jan 2019 20:53:26 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhKF-0001lz-1M
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:53:16 +0000
Received: by mail-lf1-x142.google.com with SMTP id i26so9320671lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CKLSuDSiUbomGh4I8Fz1drCWaMjb7DVbiuB6C0KO3NA=;
 b=qEylvC1tIWWrajc6u8JkeM6spEmKlLzZhCxFWzYOs5PkStF7o5brriirrKqXYMPUMY
 RkKy/7hYSADhegHFVrKBOa/m97rTucc2ldHDy439dQUEoPfLhoVrfmB8dZYHK2bRmVFj
 Vz0xPpOdrKoXQwmhtZ79+R8U0qaV5GZMxSkAv8rt4NU0fYq9/GQ2ZjjUZ6eTbR2T9P9h
 XxCo91nbt05U9F7bHC6lPuc/XlJ5kmaza1JzkXph30K5UeBpbgatGdM4c5FwTZVYJMjP
 0ApEx5WvDWu7fxFGl8KexsRMWUGEFTNLxNN/bc2Lpx0BPlVFkAg5C03OWcIIK5K5Nkti
 /nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CKLSuDSiUbomGh4I8Fz1drCWaMjb7DVbiuB6C0KO3NA=;
 b=Bsw6yQYLJEIJZ+L6QX9LXiJERcr1bS/1xyAoDmqplUyg5wErn7wVTSYweYMpReb7ju
 6eUS4on6GtQnFKFckHt9bUKxZK1JcMIIRsOWRwdhYXy6fOKqAfTl0J4VOmqreiiaRCjf
 CIWjiOaZSUVZdOHJz9ndiI4MZio/SMQcqsEbORGV9qPk0FhUhVBNtQWRXX5FXNimjL7k
 QTIgcvCvVHkNpim1SzT+vZI3cQj4aQp69/TSJMsLM9gVuUlloRg8mW+5asRiMND2DBNF
 Zg0gh76sDUAwj794VRF5h/CrvNZjND7LgOHhLZ1fWdqCzUUadJRhZjCnXCemkeI6uNWO
 vMkA==
X-Gm-Message-State: AJcUukd+MSSsh3SKV85KLe7Zz12RHt0jaO9npjY8//oHooSLAkbWlk1A
 aK0dfyHQCUqK+KVlPwsF6OU=
X-Google-Smtp-Source: ALg8bN6ZHHz3k1uF66q/M+s39R9kCKkICx9Zi3c+pYrJ6cC8iJmhLtwjwql25urZvdAOxm4reiHdTg==
X-Received: by 2002:a19:10a4:: with SMTP id 36mr6698911lfq.60.1547153593330;
 Thu, 10 Jan 2019 12:53:13 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
 by smtp.googlemail.com with ESMTPSA id
 z7-v6sm15389690lji.42.2019.01.10.12.53.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 12:53:12 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: kgene@kernel.org
Subject: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
Date: Thu, 10 Jan 2019 21:52:12 +0100
Message-Id: <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_125315_074880_8ECFD18E 
X-CRM114-Status: GOOD (  12.92  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk,
 krzk@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBjb21taXQgYWRkcyBkbWMgbm9kZXMsIHdoaWNoIGFyZSBuZWVkZWQgYnkgczVwdjIxMCBj
cHVmcmVxIGRyaXZlcgp0byB3b3JrLgoKU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3
ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYy
MTAuZHRzaSB8IDEyICsrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0c2kgYi9hcmNoL2Fy
bS9ib290L2R0cy9zNXB2MjEwLmR0c2kKaW5kZXggZTk2MTM0MTgyMjhkLi4yZDU1YTNhNmU3OWUg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaQorKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9zNXB2MjEwLmR0c2kKQEAgLTI1LDYgKzI1LDggQEAKIAogCWFsaWFzZXMgewog
CQljc2lzMCA9ICZjc2lzMDsKKwkJZG1jMCA9ICZkbWMwOworCQlkbWMxID0gJmRtYzE7CiAJCWZp
bWMwID0gJmZpbWMwOwogCQlmaW1jMSA9ICZmaW1jMTsKIAkJZmltYzIgPSAmZmltYzI7CkBAIC01
MjEsNiArNTIzLDE2IEBACiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwogCQl9OwogCisJCWRtYzA6
IGRtY0BmMDAwMDAwMCB7CisJCQljb21wYXRpYmxlID0gInNhbXN1bmcsczVwdjIxMC1kbWMiOwor
CQkJcmVnID0gPDB4ZjAwMDAwMDAgMHgxMDAwPjsKKwkJfTsKKworCQlkbWMxOiBkbWNAZjE0MDAw
MDAgeworCQkJY29tcGF0aWJsZSA9ICJzYW1zdW5nLHM1cHYyMTAtZG1jIjsKKwkJCXJlZyA9IDww
eGYxNDAwMDAwIDB4MTAwMD47CisJCX07CisKIAkJZzJkOiBnMmRAZmEwMDAwMDAgewogCQkJY29t
cGF0aWJsZSA9ICJzYW1zdW5nLHM1cHYyMTAtZzJkIjsKIAkJCXJlZyA9IDwweGZhMDAwMDAwIDB4
MTAwMD47Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
