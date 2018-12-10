Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A104C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAD72082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X8W9hB3S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4aE/9tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAD72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Apn8zN6CftTK8rZAYTtk9VZu3GyvWUyf4h1HJ5U5AyU=; b=X8W9hB3SDtMmBh
	0XnrV7hZfE8G9S45Ne2M24zXeiBTpJ+DZv9uTeC+PpShVz8dLpOD6y5E0RbfQaGcKmMMsiU1g+Na2
	ZnCbEatXCjulIZ4ti9cl6lOOIeKmzPBxWUgUTyoLgr5rQky9JVrNs+Ee6XRHonjs3/zdlcl+znZpi
	0ScVeyl+5UzYabzRn3O/tSBXzorT3t9PDXFonAMxIRsUDXnhe4qilWBaPSsSYzOPHF+7rVv/nXIOZ
	plAvIY4Vh6VwEz33gTsSOEIT6rTRhpx6nwcgtko9Avujd+4PUgB2esbvWOV4/Mq8/z3hnrNI6ZkuU
	K4kxvlPlkXPdLTRUDVrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPVg-0001MO-K4; Mon, 10 Dec 2018 17:38:24 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPVQ-00010Z-Ax
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:38:22 +0000
Received: by mail-pf1-x441.google.com with SMTP id z9so5736007pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
 b=T4aE/9tVdvdKbD1qV6t56JGFjbK5DnIBBewRd1FAVKSLl2ircbuiqvbq4IujPowJfJ
 0fQ1S9frWf49eaZhnA1iyCFA7xEOoCM0btUoKccwz2VUcV79S+rmzC7HxL94H7nBnhms
 KdRPO1VXtaFvvevtbn7ISihZ1+2TimQPTPz7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
 b=dmaka197RfMevyNCd0lz549bSAcxgTjYX9GyWA9NiyWw+GVzWtogMtTS/SN6v1IX5S
 OEmaNhROENehnncGNqbYhk4A5dGnABhTNJtos1aKFbJAEBiBUZQaZBSgZN2lezSFgYLD
 PO4APtEK6HOUkp1Q2t9EXyOeUIj2tdfN9j1lFtd9q1bGsX8bc4RWeDVcOHnAX12dSSvy
 GbI15JP2crleqNA8rFOcp7YnFotdsTW1NhiSX0LrWaoeOC7TTx66GLnquW+ow0yABu0b
 6Fdq0rNrJMQtttlmdrK1MWurjAxoKj2WpuUljKsWeoyKa2gJgcUPqN3Bnc4nG5Fm8jOT
 MZLw==
X-Gm-Message-State: AA+aEWaq3GqZakJYoKFs9kn/sfGXa/cPxtQZwUd5UuRtSqnvMtXWC33I
 LMER3vFXtjlRaShikjLIlwAK
X-Google-Smtp-Source: AFSGD/U+Io0p59DhFow06bx9KYAM+nPTTmsP/eKC8VLs20FZttEOnHkV9lu/f6Z/PSYevW/7qi9PYg==
X-Received: by 2002:a62:cf84:: with SMTP id b126mr13041885pfg.98.1544463477719; 
 Mon, 10 Dec 2018 09:37:57 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:37:57 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 13/15] ARM: dts: rda8810pl: Add interrupt support for UART
Date: Mon, 10 Dec 2018 23:05:48 +0530
Message-Id: <20181210173550.29643-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_093809_090034_8D59B1D8 
X-CRM114-Status: GOOD (  11.66  )
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

QWRkIGludGVycnVwdCBzdXBwb3J0IGZvciBVQVJUIGluIFJEQSBNaWNybyBSREE4ODEwUEwgU29D
LgoKU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpTaWdu
ZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBs
aW5hcm8ub3JnPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNpIHwgMyArKysK
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9yZGE4ODEwcGwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4MTBwbC5kdHNp
CmluZGV4IDg0YmFhNGMwYTE0Yy4uMTljZGU4OTViZjY1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9i
b290L2R0cy9yZGE4ODEwcGwuZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwu
ZHRzaQpAQCAtNzEsMTggKzcxLDIxIEBACiAJCXVhcnQxOiBzZXJpYWxAMCB7CiAJCQljb21wYXRp
YmxlID0gInJkYSw4ODEwcGwtdWFydCI7CiAJCQlyZWcgPSA8MHgwIDB4MTAwMD47CisJCQlpbnRl
cnJ1cHRzID0gPDkgSVJRX1RZUEVfTEVWRUxfSElHSD47CiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQi
OwogCQl9OwogCiAJCXVhcnQyOiBzZXJpYWxAMTAwMDAgewogCQkJY29tcGF0aWJsZSA9ICJyZGEs
ODgxMHBsLXVhcnQiOwogCQkJcmVnID0gPDB4MTAwMDAgMHgxMDAwPjsKKwkJCWludGVycnVwdHMg
PSA8MTAgSVJRX1RZUEVfTEVWRUxfSElHSD47CiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwogCQl9
OwogCiAJCXVhcnQzOiBzZXJpYWxAOTAwMDAgewogCQkJY29tcGF0aWJsZSA9ICJyZGEsODgxMHBs
LXVhcnQiOwogCQkJcmVnID0gPDB4OTAwMDAgMHgxMDAwPjsKKwkJCWludGVycnVwdHMgPSA8MTEg
SVJRX1RZUEVfTEVWRUxfSElHSD47CiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwogCQl9OwogCX07
Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
