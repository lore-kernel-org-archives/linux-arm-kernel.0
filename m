Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3C420874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="snI+80/B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tm6g49O+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3C420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ApCcTXkyD5zFyfbhIGPyJu+ng5otjKziVZdLimWJwgg=; b=snI+80/Bp9Ds+5
	p5s+aQV+D5rCGsYQCXiNomB2MYRNxvxBZtt2NegtxtSiIzoUjFBUavnxlTmTSokinMKvQWgoPqE0I
	Nm6k00faQjXzmJy5zGNQvv6bZFopuuAJaTPblTmohl3DilpAp0FUfxqthS4z9SYlffcqkDM6TQEJ0
	LHRq2FcSjIQ7yy2oM+n/ftl0NdXfLfoF20aGftbDw8L4RhFl4vR3Ldr9/ry2zEZXt5AV0eCGLIl7A
	gxmNbQ2DFl6EPAIJhspplL1/CIyu+Fl0Ic+5jM6xetynvII48xVogCMp1zsOAB+6Z6PReg/jG7N9A
	ZE2Sd7iMFwjfN7+iL3bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6Ha-0007Aj-2w; Tue, 18 Dec 2018 03:42:58 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6H4-0006St-IN
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 03:42:29 +0000
Received: by mail-pf1-x442.google.com with SMTP id g62so7405027pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 19:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
 b=Tm6g49O+RRHfWZtvubic6SeVrt2fHUwKabPBv2ob0nb1OM6kshsILlg1evZ47yCWU9
 aARGR82ToU9h0ElUCinl+FVOIc3mdIRR1M5AaN13IB+ZRVa8vRXFBOGZyixULa4H3vNh
 KdciPI06/UK9CWYU7QgIUdACSJNgFhbOTtbeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
 b=IuRhz+Q2Q5xsWP9AHAyvr/SBxVE1Uk5hNKDYzEUzJoOTr6oC+7baaJItrE9UjYKp+o
 /uM5enQo+7XmbFae4e5tSqc1APQhXy26Wo6fIqHb9iiXH2ki6qjNoREwiEWGzOJ9X+jO
 vBydxvYlx3yphu8jcv4t7DtJyr8CDfZ251/B8wrs+AMlWyfq/mzoFNmN4CeekldThouC
 TfFlk5wDMu1xHoARE383BNHWPHzV19LkrArtLYWPSK8qLdKoOLxnGHPgOYADuHFMlT+h
 xEkYWfAgSDIdkn7AesSMX4LE7kPNGGsVDtImNW0TFXTUOrCbxkSYCGyanbzXL7NZmWzh
 RtNA==
X-Gm-Message-State: AA+aEWbXyGcZCSbgl0mL+KcRwtGuWWFzmpwywrIOeZt2d8IMjtCr/NFL
 Ienl56a0dCU+dw2e7opJM6yZ
X-Google-Smtp-Source: AFSGD/Ub6mPRKxF/E8ahh/Cn2J27S0hcRX1HDhxBahENNulVpIPMcfaFpFnGBqiavjWWyZ01AeOdOA==
X-Received: by 2002:a63:6b05:: with SMTP id g5mr13961670pgc.15.1545104535506; 
 Mon, 17 Dec 2018 19:42:15 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 19:42:14 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v5 02/11] dt-bindings: arm: Document RDA8810PL and reference
 boards
Date: Tue, 18 Dec 2018 09:11:23 +0530
Message-Id: <20181218034132.5070-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_194226_618629_384BE0D9 
X-CRM114-Status: GOOD (  11.84  )
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
