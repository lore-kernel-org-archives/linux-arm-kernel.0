Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:19:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2196321873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LUkxBq65";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vr0ulnX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2196321873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1eIHPcwo7Ok0RImRLbG0fiVU3Pipd7Q5XirZtBOngQY=; b=LUkxBq65V3dqrj
	bfK9zqVtbt4aDiwIE630d8eLZQWD6mas7vlAPFVKbcEEHZVdCKsgmJKPUch6PsV8dzhSLO8Z3LLMb
	tc2YOsEcc57dlnIjXaBmQX8LZYPFYsQNcXL7Auno2cGJuZffyC8smlKSoq/4G8/w1K1xv50eZ5Yt3
	C+nVBXo+3yelxpWhtgPHRHcMLk8lPFEhGZ0H5csYMXweQGAXfLkONsnM1c3jZuSGND8CWJ+4Yb9bd
	MPL83zn1IHkQnnr2GJYzmX2pb0KLDR9/J0zCTwAWtiMV4jjH8biaAXvWOYgB6RazXQfAopm/pFHOI
	5RploYqSeUO5nkneJEBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZH9m-0000h3-6Q; Tue, 18 Dec 2018 15:19:38 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGuh-0000sP-QX
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:04:18 +0000
Received: by mail-pf1-x441.google.com with SMTP id c123so8275429pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZyE2u/x6knKCVFcTEeQSNyr8fOyOJ4nkYkMjo3bMh2M=;
 b=Vr0ulnX35CEGh2MCG+DB8I5x2nAWwFenlVCA4OL7ruMkJP+7SNlJ6N1qvYHMRwNQrf
 cgpYWp7aPElCv4rkpvtcTQovERPPk9i3gOWXOB0jX9pK9hmEwljrVP+IF/XExrxK9e4P
 l3C2icU6all4dweckFJVtVo7hXrQFwLcIzlj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZyE2u/x6knKCVFcTEeQSNyr8fOyOJ4nkYkMjo3bMh2M=;
 b=JffJMj3MCZJmElx8b+XHUROpWBwWwLymtZhusiAp04lucw02EXKrNM0OX69FROW00E
 w4emmhp95vRRx71Misfrkt7BjlOBIGAkgSMes314DQI2SPa6gMeedFNYW14oF1JsXPwG
 yvsmOuGl2M+WRMiY5Fm4kvliskgI4xo51qrbmNBxOvRqliF5s+6FeNJMpVeNIB3cUNj3
 v723ld5LlMRYb/c/yWYk61XzYvxTvIq5Bkz5ZA0n14ZftVP9D+9qyBIMzWEmrBPgjIou
 4p5NSRVmXyOiBpET5wUm9yCvnf2l3iqGVBL3gsVi1G0o69f8IW2Dfz3B+vHcNfkuC59R
 A4zA==
X-Gm-Message-State: AA+aEWb46HxhVbXPoexDH2X0kKz+bIlbO51iNn/yiHv3UVjin6D7z6G0
 J5/JuL32l8iKm/AQbKhXTEvW
X-Google-Smtp-Source: AFSGD/Xk6jxsVPBjTImvDMuUNVfX9dobCUceaV1lugNfBzC4qh4ZQNOfLOE0hOFgmO5S+rc5dUYqnA==
X-Received: by 2002:a62:34c6:: with SMTP id
 b189mr17393861pfa.229.1545145441586; 
 Tue, 18 Dec 2018 07:04:01 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:04:00 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 08/11] dt-bindings: serial: Document RDA Micro UART
Date: Tue, 18 Dec 2018 20:32:35 +0530
Message-Id: <20181218150238.23010-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070403_973683_EB0C8CB2 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKQWRkIGFuIGluaXRpYWwg
YmluZGluZyBmb3IgdGhlIFVBUlQgaW4gUkRBIE1pY3JvIFJEQTg4MTBQTCBTb0MuCgpTaWduZWQt
b2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6
IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+
ClJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgpBY2tlZC1ieTogQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KLS0tCiAuLi4vYmluZGluZ3Mvc2VyaWFsL3JkYSw4
ODEwcGwtdWFydC50eHQgICAgICAgICB8IDE3ICsrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgMTcgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcmRhLDg4MTBwbC11YXJ0LnR4dAoKZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcmRhLDg4MTBwbC11
YXJ0LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcmRhLDg4
MTBwbC11YXJ0LnR4dApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmEw
OGRmOTdhNjllNgotLS0gL2Rldi9udWxsCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zZXJpYWwvcmRhLDg4MTBwbC11YXJ0LnR4dApAQCAtMCwwICsxLDE3IEBACitSREEg
TWljcm8gVUFSVAorCitSZXF1aXJlZCBwcm9wZXJ0aWVzOgorLSBjb21wYXRpYmxlIDogICJyZGEs
ODgxMHBsLXVhcnQiIGZvciBSREE4ODEwUEwgU29Dcy4KKy0gcmVnICAgICAgICA6ICBPZmZzZXQg
YW5kIGxlbmd0aCBvZiB0aGUgcmVnaXN0ZXIgc2V0IGZvciB0aGUgZGV2aWNlLgorLSBpbnRlcnJ1
cHRzIDogIFNob3VsZCBjb250YWluIFVBUlQgaW50ZXJydXB0LgorLSBjbG9ja3MgICAgIDogIFBo
YW5kbGUgdG8gdGhlIGlucHV0IGNsb2NrLgorCisKK0V4YW1wbGU6CisKKwkJdWFydDI6IHNlcmlh
bEAyMGE5MDAwMCB7CisJCQljb21wYXRpYmxlID0gInJkYSw4ODEwcGwtdWFydCI7CisJCQlyZWcg
PSA8MHgyMGE5MDAwMCAweDEwMDA+OworCQkJaW50ZXJydXB0cyA9IDwxMSBJUlFfVFlQRV9MRVZF
TF9ISUdIPjsKKwkJCWNsb2NrcyA9IDwmdWFydF9jbGs+OworCQl9OwotLSAKMi4xNy4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
