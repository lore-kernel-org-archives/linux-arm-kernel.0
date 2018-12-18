Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A43C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F8B217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="suEPrVW3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcH3b1xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F8B217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ApCcTXkyD5zFyfbhIGPyJu+ng5otjKziVZdLimWJwgg=; b=suEPrVW3tQmnew
	yWwh4iWvTmIxE3kBuGofIc8AC0RNqw61e10IVtQwwNIunuxkm9CzkUCvv4IGwI/S/lPuIMPFqReN+
	Mj5ZpdK1ESls8OWfsGXdcebyswFCF0OodZ4dg9lR9jae03JlB0xoFtv6HK6zhfaTwV1kH3JC6l4mT
	hVtGCQ7/KWJycbksW7S6r8NTsxwSr5cmue9h3cFPZL3CWJSBWG2WLUVR+fLX+6bHEje1f1SBxTum+
	hmxpkuap4VHGuS5iB0MtvltdTZLl7QhuyCafnh3+4YgFfe3EuIaYAsb/+SfF2G9aedAWLXxV58ZTk
	+stJKeFNUqLTJfmT4+uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAOd-00087z-3T; Tue, 18 Dec 2018 08:06:31 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAOI-0007lA-3K
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:06:18 +0000
Received: by mail-pg1-x541.google.com with SMTP id c25so5944441pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
 b=DcH3b1xcnGQ1BcPq6ECEQup2GRLxMkV3PeH5zC0gPgHMGbehApMKAU7kBb0UlhvQkR
 y2A7RkUgscuQau0aHUVVc9uJM3AyqIlPqIViWL0qsUVls4TJOiTPTRaquNB0DWlfMlLj
 zW7CKUNvZl8v3HUudEZlkLCLcyfFeS12CNPh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
 b=S9O5S2uTfikrODlC7ynXt9/o79zwR62AbWeB3R/ASurrCdp0AZ7RtBxGccoa/As1LE
 qhKlHPMq0LhclwylzmMASh6yO7XGhXeZ+NuhrZBTRlje7Gc9L1gWutTl7aXtTXPHz/Ag
 +Yhm3YGHpeN2qz8c9DqgXr5SmMrbryx06Jcz5pesfVH+8sO6rMG2SOYHkXFR5gz8RPtu
 618VNr+bNAaeGOg+VnNF+fggQPEW2X0ilDtFcTWXD7YfJWhuYkiRLsbNCDtIyBb8fkBO
 4BBuRjZGfRKSgGWBfRVSEcgqKZw9UC+Cx9jJSNmEV0UNcFSvBZ7Cf0YzgSsFaNadIEvv
 8B/g==
X-Gm-Message-State: AA+aEWZ7+U24BV0nNO5/ubch5wvg5Zqnc9xo8Kqm9mZB5y7jFOp5xBfU
 DhkL8D9sZj7zXfhd7bHrWiEW
X-Google-Smtp-Source: AFSGD/XkaZuIJJvmOg7GARLhnf/nuYQfCxYXnqpA+f9YZifBSVUtrUJZzw3PdqceTj7YBRF7+/SEQg==
X-Received: by 2002:a62:6a88:: with SMTP id
 f130mr15936587pfc.201.1545120359191; 
 Tue, 18 Dec 2018 00:05:59 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.05.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:05:58 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v6 02/11] dt-bindings: arm: Document RDA8810PL and reference
 boards
Date: Tue, 18 Dec 2018 13:35:18 +0530
Message-Id: <20181218080527.10801-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_000610_617651_2B9F51C7 
X-CRM114-Status: GOOD (  11.01  )
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

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKQWRkIGJpbmRpbmdzIGZv
ciBSREEgTWljcm8gUkRBODgxMFBMIFNvQyBhbmQgYmVsb3cgcmVmZXJlbmNlIGJvYXJkczoKCjEu
IE9yYW5nZSBQaSAyRy1Jb1QgLSBodHRwOi8vd3d3Lm9yYW5nZXBpLm9yZy9PcmFuZ2VQaTJHSU9U
LwoyLiBPcmFuZ2UgUGkgaTk2IC0gaHR0cHM6Ly93d3cuOTZib2FyZHMub3JnL3Byb2R1Y3Qvb3Jh
bmdlcGktaTk2LwoKQ2M6IHpoYW9fc3RldmVuQDI2My5uZXQKU2lnbmVkLW9mZi1ieTogQW5kcmVh
cyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNh
ZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgpSZXZpZXdlZC1ieTog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KLS0tCiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL3JkYS50eHQgfCAxNyArKysrKysrKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDE3IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JkYS50eHQKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JkYS50eHQgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL3JkYS50eHQKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAwLi40M2M4MDc2MmM0MjgKLS0tIC9kZXYvbnVsbAorKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JkYS50eHQKQEAgLTAsMCArMSwxNyBAQAorUkRBIE1p
Y3JvIHBsYXRmb3JtcyBkZXZpY2UgdHJlZSBiaW5kaW5ncworLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQorCitSREE4ODEwUEwgU29DCis9PT09PT09PT09PT09CisKK1Jl
cXVpcmVkIHJvb3Qgbm9kZSBwcm9wZXJ0aWVzOgorCisgLSBjb21wYXRpYmxlIDogIG11c3QgY29u
dGFpbiAicmRhLDg4MTBwbCIKKworCitCb2FyZHM6CisKK1Jvb3Qgbm9kZSBwcm9wZXJ0eSBjb21w
YXRpYmxlIG11c3QgY29udGFpbiwgZGVwZW5kaW5nIG9uIGJvYXJkOgorCisgLSBPcmFuZ2UgUGkg
MkctSW9UOiAieHVubG9uZyxvcmFuZ2VwaS0yZy1pb3QiCisgLSBPcmFuZ2UgUGkgaTk2OiAieHVu
bG9uZyxvcmFuZ2VwaS1pOTYiCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
