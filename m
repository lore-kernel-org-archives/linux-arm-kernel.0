Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26612C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:33:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFB7214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u5vgZg74";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WZ84Fxw1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBDFvHX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFB7214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lXmsnqrEsDrRgHEYqkioE8uRsXYCyMPdtkypC0xwneU=; b=u5vgZg74aM89pF
	5xiJhbRaXwmcSxzfjdVbdoUeQT4fJjvJNpZuF0JMa/5damXD8w0iVxVHFHowHgUEyAvPkv4zyd0dW
	xg5OBwWVyDbTa5lNeuwnhIQnvTLLzBC7I589wDLYGRaWLHL3q+cfizsb/rURyqOKPFVsOrJCxM/nz
	PRP8+UpYanZHfhTg6URDYZyVMa08S0O3xjG7rwR6QxyKbLmOkk4uU8BJg9g+sEkHX1G4+a4alFWBC
	YwAY4WkXZdOUEUSyd2oQNFbweHulg8T2izjJ9VS5H1HgUUuPqQLOmOOmshj7o12Vr4fBOF2CwSuzP
	+kKeIBK7A3MtYOSLLyDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ73z-0003sE-5J; Tue, 18 Dec 2018 04:32:59 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ73n-0003gJ-VG
 for linux-arm-kernel@bombadil.infradead.org; Tue, 18 Dec 2018 04:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=; b=WZ84Fxw1JzJHtR1s5axX/OMFzo
 IE2C+FxFsd8xzqeB8JHbNvsFMbYZrq4gKruYP40WtvVGfswt+ZG6zHFg7TIm4Tx/WLIJNOh5ASQ36
 qCuvMwqY1fEH92rj2oG3u6QEEoKO1kYfsP/1q28dQmhh79G7b8pyCGGx85mDD9RiKcFHLpIFd6tJJ
 mfQE7BWNXWo084J9AXq8/iKi0+OZXz5vRONtKzIFi/+mBMT+gOUEgkpWQLSygKDpxdZtiZKS/6LyW
 zi+DjLkoIJuP17u/aAUzIin7b6Sh30wnffvUbCEyO8GCkwu8nuDjStuxq/IG9ivhTeQi5O0EfLdAg
 uHmGuDKA==;
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6Hd-0005R7-NN
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 03:43:03 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so7154799plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 19:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
 b=YBDFvHX7AiucyPS8BT+C9ypYixQsdfJG7w9Nw/JM1sLJJBbysciZj38Z7NbumJjmEb
 Zikib+uZNRRj8XAUHEFg6sQ+1yZbNOphofHiQavO4CeKVEb+FhcCnHL/mTqjVwpfNRtV
 kUlMAkNyD3vs80tduMbIGmsdT92ra6ei0ckCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
 b=gaHaO1QVk32syfCQJcMSxm6ycpDOl8+653QiNultbCJPKTwyKwIOpMZ9q8cXjsonTd
 hB4qXB3ferZwOFWzLQfcjhnUawLd/6Oar4lcValr6mHdLM7BXr2eOw9perQq+fMpqU/B
 ztx7lqq29on73XFJK0DOQzg5pofdM98+cMinSxBYoydm9b7k6xPR7CzsiWD9jczJ+nWQ
 zWTMYVLNM1wGTQcNBALWbgUMsbrRE48sWtCksO8Teg4leIOF7ovH9ynGTmqLV6J5CpM6
 gAcnH60eIjV+stWFjYoPakafBe0subBTERkd0/aWD6WxAbaFQ73daIP1LpGsyORfWKQ/
 1gmg==
X-Gm-Message-State: AA+aEWbY9BIDu3nVPeWPGzR8q4+EwdWFY1TK7KH3BMt8hOCSZTqV+8su
 dqF6YNy3L4zOoI+lCen7CQHc
X-Google-Smtp-Source: AFSGD/XHItxOIu1KkoZQlSL6eFA4WYQq8HdFiNJ7nJINZBrDQhCI33qZh6eC7nwl7lgfYaQ7/DXApQ==
X-Received: by 2002:a17:902:4124:: with SMTP id
 e33mr14993867pld.236.1545104573365; 
 Mon, 17 Dec 2018 19:42:53 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 19:42:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v5 07/11] ARM: dts: rda8810pl: Add timer support
Date: Tue, 18 Dec 2018 09:11:28 +0530
Message-Id: <20181218034132.5070-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_224301_788263_693025EC 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWRkIHRpbWVyIHN1cHBvcnQgZm9yIFJEQSBNaWNybyBSREE4ODEwUEwgU29DLgoKU2lnbmVkLW9m
Zi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBN
YW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgot
LS0KIGFyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpIHwgMTAgKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9yZGE4ODEwcGwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpCmlu
ZGV4IDE1NTQ3YjEzODk3Ny4uODRiYWE0YzBhMTRjIDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290
L2R0cy9yZGE4ODEwcGwuZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRz
aQpAQCAtNiw2ICs2LDggQEAKICAqIENvcHlyaWdodCAoYykgMjAxOCBNYW5pdmFubmFuIFNhZGhh
c2l2YW0KICAqLwogCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIv
aXJxLmg+CisKIC8gewogCWNvbXBhdGlibGUgPSAicmRhLDg4MTBwbCI7CiAJaW50ZXJydXB0LXBh
cmVudCA9IDwmaW50Yz47CkBAIC01MCw2ICs1MiwxNCBAQAogCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsKIAkJI3NpemUtY2VsbHMgPSA8MT47CiAJCXJhbmdlcyA9IDwweDAgMHgyMDkwMDAwMCAweDEw
MDAwMD47CisKKwkJdGltZXJAMTAwMDAgeworCQkJY29tcGF0aWJsZSA9ICJyZGEsODgxMHBsLXRp
bWVyIjsKKwkJCXJlZyA9IDwweDEwMDAwIDB4MTAwMD47CisJCQlpbnRlcnJ1cHRzID0gPDE2IElS
UV9UWVBFX0xFVkVMX0hJR0g+LAorCQkJCSAgICAgPDE3IElSUV9UWVBFX0xFVkVMX0hJR0g+Owor
CQkJaW50ZXJydXB0LW5hbWVzID0gImh3dGltZXIiLCAib3N0aW1lciI7CisJCX07CiAJfTsKIAog
CWFwYkAyMGEwMDAwMCB7Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
