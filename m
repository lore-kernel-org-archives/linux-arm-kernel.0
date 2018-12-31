Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:57:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D20020B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sQFM4ipS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4nu8Cja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D20020B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=99zA1FBLGKZYjrQQMEpzqQ0i7+Ir8Xr00TnHZasknJ8=; b=sQFM4ipSt2Yb2g
	xy+Btx6zpQTKuwu4vaEdw1i7KYxUNyQLwvsEmjRpV30iqtXKeU+uepdI61kkep8VK4eQAea1/XE1l
	0LkRgX5ESuEDxWK7VBmHH03MLFUmZOJK4pTgfvfu3S6TWtCptGwtL4AjeMQsNiLJhOdfnQpZVRnwN
	JnXki7QV3Ap2FQGVtX0M0DPRWnXyhdugkcMI6imhNtFxcny8nibjjJMzlfaa6Gf52csl0gEAYzCh/
	QKW8CtUvffWU3Rp2xZOgQRU7CLqNzWSZxnBezUc0HHwkOE/SDccesLtcPp+8c0H03o5o1TnYiATAG
	Uz5uocBpUOVa1bAVKSSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge2l0-0004aF-VJ; Mon, 31 Dec 2018 18:57:46 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge2jZ-0003VP-OH
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 18:56:48 +0000
Received: by mail-pf1-x443.google.com with SMTP id i12so13465977pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 10:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EmFI5a8lPjCMuBHux9Ylzns+RwprhO23lrIeWOAs4Cw=;
 b=W4nu8Cja0NZNaGlpKmet2nCOvwvs+V9OUNGUYT6vL9a96lzBBU9hwnGPa0/QO6/N7V
 JhnRIZ2Sg7oWgg1VAsSmMkS4UaCg6Z7d4gF27U5+ay789PISSTjkhjJfKFfUikh1VwoZ
 nJ0EUPTrJLFWHggWgz//MNCkty/ZLuQs8xg1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EmFI5a8lPjCMuBHux9Ylzns+RwprhO23lrIeWOAs4Cw=;
 b=FYGbXUy6eJzhmZdkSvih4CAD9FDYCgWz7vq9TKHi7aARMNKiJdURS4mZTN1WETdk5f
 gpl82XJHK1ObDFKhpUF3fVMi3G2N8+XQxQW7RqFnbcNNAPbY8rNthuq2u/6+KpJIcvJT
 D7Rz5O3kgLJMUK9PTPZrmw6d/do8qHzwyPNZvqcckzdrWE4VIlm8PlFV4iW/xMY+DENr
 H2gj917TTlwKppL5fxGLGSTnGp38NcC6WQ9uLZBLLBtNBeubxHEFygyjDf7f204IlJp+
 4O8KreeoT1ZMiv2xGqJiqRKrfMlhSL2VTfrQKz8hUQ6PdsC+w07f5lujSbtxyqwaqrJi
 MiKA==
X-Gm-Message-State: AA+aEWZrfKgZt17nfgsLGQ2nnwRf5raDMz/tK3Wi/2UwmNpCNOmpKGvc
 vslnjO8DZ6OyjCrW0w7sPB5C
X-Google-Smtp-Source: AFSGD/W4CZPMYeZnQs2N+vGT5R6DNgkdzBwfT/FBzlWKkgdtK7qR7JuylOG3A7ZrE5mQVJiX4iHgEg==
X-Received: by 2002:a62:d0c1:: with SMTP id
 p184mr38627489pfg.245.1546282576851; 
 Mon, 31 Dec 2018 10:56:16 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
 by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.56.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 10:56:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org
Subject: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for Actions
 Semi
Date: Tue,  1 Jan 2019 00:25:17 +0530
Message-Id: <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_105618_485402_7187D8C5 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWRkIHRoZSBsaW51eC1hY3Rpb25zIG1haWxpbmcgbGlzdCBmb3IgQWN0aW9ucyBTZW1pIFNvQyBh
cmNoaXRlY3R1cmUuCgpTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2
YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgotLS0KIE1BSU5UQUlORVJTIHwgMSArCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01B
SU5UQUlORVJTCmluZGV4IDdkMzdmOGE0NzQzYy4uZjMwZTI1YzhlNGE3IDEwMDY0NAotLS0gYS9N
QUlOVEFJTkVSUworKysgYi9NQUlOVEFJTkVSUwpAQCAtMTI0MCw2ICsxMjQwLDcgQEAgQVJNL0FD
VElPTlMgU0VNSSBBUkNISVRFQ1RVUkUKIE06CUFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3Vz
ZS5kZT4KIFI6CU1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxp
bmFyby5vcmc+CiBMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVy
YXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQorTDoJbGludXgtYWN0aW9uc0BsaXN0cy5pbmZyYWRl
YWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVycykKIFM6CU1haW50YWluZWQKIE46
CW93bAogRjoJYXJjaC9hcm0vbWFjaC1hY3Rpb25zLwotLSAKMi4xNy4xCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
