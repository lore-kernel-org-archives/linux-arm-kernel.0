Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C08C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368DE2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D6h0QU9q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAXuJ8+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368DE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ApCcTXkyD5zFyfbhIGPyJu+ng5otjKziVZdLimWJwgg=; b=D6h0QU9q8IPmVE
	VlGr/X9IUJRfeaxbMBYkT6zcnwWy6xhhyGPzVe6/PCvprBknNlkQhmD8qXVFwE5NwZ/AI3U0rldSI
	FUCX3m0OtQ66YaNFxqz2WRiKXM2BKO2xi/yUbxasY75ngmlXc0Z7VGVEzD+jYnRzXpdr05GlAc5EA
	PcGTv0y6yOa03FePQ3nO4dAVaQoe2dmdIhxqlcsk6/gDp/sGt5Twctd0jbezO6KN9khqK/ujpp8vr
	DqV2rKXdJybu+5TqoD0c5W9ISQwIs0RNt/Uma19JOsUmCUre3N3VB5p5HiwIROo4YfXScT4dDHras
	Gd5v2+zwqhajpLNL/UuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPUA-0008Nf-4Q; Mon, 10 Dec 2018 17:36:50 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPTs-0007um-HZ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:36:34 +0000
Received: by mail-pl1-x641.google.com with SMTP id y1so5558528plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
 b=YAXuJ8+RB2DXLXlJjsmBYxPGPKn8PUw3SYbKrETOx3OzVKs/4hNH2LDxhRL4bx/nAL
 I6Xeb0BnrvGPC+hEni1mM32Et0Yddd6GVEjV5hUcftlvTlQuf3cb3uOxl+8o8i9a17/G
 YWGO2AKH/r+d/60k6/pO5d7gsNDwZaRjiMoA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
 b=eLA1Dc0wjs18NjukiHhIXu4cC5IhJmMs8X9i9pyRtCKmXxQhCLOSP/HkiMzTc/sOJy
 +S7yxqQsEr454X+l7lalBv+cNF+UJnXzQOdoqkQHf/+3yhOwdbZly/z+qXwMnaAjkI19
 E16Z8jMTWIyNL+P7IEtOookZ+VSefbnNwys/+c+CZbHOReBftQy1hm68pfTBW/Lq3nHO
 deZVVR2BAFMvV5YqTYLKgOI1wW3XWutPTrPvRfTBw9Imd662ukF2sc4rBptbDVfmrl2l
 sAGpzSfuqNI7ncev3ZORsf2oerK1kvzjzaGLvGSjxx71LOMuyEIifTa3BdnWyZ/+7kYN
 aTaw==
X-Gm-Message-State: AA+aEWbVRlbEcgwNi2NUv9BxOJgbnRyy7rzE7dEvGsLGmXWnnFnlgM66
 cCV65AJ7slKgPFz/Agj/3Ut5
X-Google-Smtp-Source: AFSGD/Wz2XxQXuAz0RTqoKVJzQmZWsvyXihZ51S8kKbW49zS79pqi/EGrLltCwFa5FSa2mfSR6VNxg==
X-Received: by 2002:a17:902:33c2:: with SMTP id
 b60mr12863201plc.211.1544463381821; 
 Mon, 10 Dec 2018 09:36:21 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.36.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:36:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de,
 jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v4 02/15] dt-bindings: arm: Document RDA8810PL and reference
 boards
Date: Mon, 10 Dec 2018 23:05:37 +0530
Message-Id: <20181210173550.29643-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_093632_594010_15773EC8 
X-CRM114-Status: GOOD (  11.79  )
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
