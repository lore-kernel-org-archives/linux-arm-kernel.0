Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709FFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346E12133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OkY6WNmu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXJ3IW7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346E12133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Apn8zN6CftTK8rZAYTtk9VZu3GyvWUyf4h1HJ5U5AyU=; b=OkY6WNmuD63KK5
	cYcxoUfKjsQ60yO3TVwQ6XfzzpXacRAojPz1QnN8hUIoiKfTsfEDkzGsi0IReuCR0WFEFS7nF1WMr
	ZeFBHNJzUvKh5bm+3QmCDbS9ArZocLIamQH8yYcnYavLIoqMjTBEbA7Ys0GAX6MFsY90wCH0ILOC1
	fw/nQojvX5aYF5TcyuIMuZ6ezmhkgMtKop58ik8SyFY9xRzIdRTrqBp8z0uMokjRbmBsOpuf5FMYV
	Q7VxKvgPG5q/9i0ut6BSLdT6zuaa+DbZpsXqjLz4fN2n8Er6fq0lB8gMIZDz73OfSs8zz12y/1DYw
	A10bxK4x0sHHc2Ih3pvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAQm-0001SX-Po; Tue, 18 Dec 2018 08:08:44 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAP9-0008R9-8m
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:07:18 +0000
Received: by mail-pg1-x543.google.com with SMTP id y4so7432014pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
 b=BXJ3IW7uYVqUSFHGn6zRnfhKmpfkZyk9RGGSU8gVMDkt6L1SUxV3i93NxB8DlWLJd+
 3Qs54lcPoImM9UuJ12mb252f4vEDdyhENsHSCl2sbEqRDEYAERrl4fTqVTqoqhn0q06z
 44BbHOaIDGhq1lyAePS4yjP0I5A4WG3EmzMDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
 b=C4u2HnwhWfY1SAg9Bl5YvIG9m3sAWAGHV5Wvsvtfu8KZCqVJzTFUb5O4wwMDAPsFxQ
 DRtB1YkwwHIosCP2GQlIo1WMnAfcRXll6cMmBSTDVSvb9wjqhLAohrMH7Rdeafup47x+
 gnf+QZ4jG4J909vdVYeaxaGtKKtnjSLsf3pZKt2mLULL5VtQ2Qgo6y3M3Z9Iinfo/Ddt
 ZpgpwwkZapFCgXc/yOkrVzhaj96OEIiK8az6+ELnxxhu34Ph6vHk1Ve6qGGbtfL3ROdh
 gdcHLOdmSZInXWulVHU6k681nYcjA0Ew4gFED4QgaWTzW/Ob8Q8F8gwQq/PiFtGJk1vh
 cFZg==
X-Gm-Message-State: AA+aEWaeYigwLDJvjaHP6BCJYneSp6NvZDezc7Oebw3fxczsCezfpZH3
 W35U2WnaFlcpYJH1MMCSLjvv
X-Google-Smtp-Source: AFSGD/ViSqwzomWYeiYBym8Z2HNI76a4fXi+BcPMIWXknJDVbFBJ5B5BzBFxFvSBn7vzU1uIDZj3zw==
X-Received: by 2002:a63:4d66:: with SMTP id n38mr2049614pgl.270.1545120412681; 
 Tue, 18 Dec 2018 00:06:52 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.06.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:06:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 09/11] ARM: dts: rda8810pl: Add interrupt support for UART
Date: Tue, 18 Dec 2018 13:35:25 +0530
Message-Id: <20181218080527.10801-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000703_685349_D776269E 
X-CRM114-Status: GOOD (  10.92  )
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
