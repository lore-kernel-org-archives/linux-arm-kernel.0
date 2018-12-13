Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EBAC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:59:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA45D2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JIC+qF92";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PeM7Xy6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA45D2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E7gPhvE1oxB0YwfVTjckL0YGsX6qdnpAmK8ftvDB2MM=; b=JIC+qF92qy/OgZ
	isWp/9dL17Jq7E73BzAZEkeKKsT+PTua6FeNMRGkwepkobK97I25t5515GTgHkpSYMq4ktJmF+wvS
	QHh5Hu0GK5PexFW254/aXf+ZBUxA8FlSS5N9cs/ZIlAH7sncxzGtHWm6tqmyoMka2dgseYIdYGetU
	w7wrDHhzi+yH6xALP1qIqdO2GNUJvT7YOKM6GElVjdQ7/kcQwQJYNjOvASBsjVt8cBWNoSvFOXGoQ
	1oAfA1Kz19OayL18uOuXxZ4Yw7EERIGHDVlUqY7FxQuBjU2bBQ8PIVF6CiNDKgk0bVgJzlcmJrWF7
	DP3HqRtHEkz8kR9qUcVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKxQ-00085W-Qk; Thu, 13 Dec 2018 06:58:52 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqe-00046F-Hk
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:52:02 +0000
Received: by mail-lj1-x244.google.com with SMTP id u6-v6so808876ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=QhSVaQYJedSA+aBywG/Ib4vn4OqSeRDKiRI2SrKATuI=;
 b=PeM7Xy6HhDd4Ayll1qqzFXq2U14GOCAaNBCoUrS6tieOelDToewJCXAG2lc6kNUUyj
 L6QitWP/OQNqFqoLHZU1wS02CoKmhqEF4loMKtNpEN8gEltkVL2Gn0yXsqvmb8bFs8ty
 nUObes5DqKjg6zxegNE2NEP586K0b8BpMU6MFjsPOQUsJRecM3+XgSdM1Y0tLHycNEPJ
 lI/x6R2XHqcuca3/pa8p+vOy3bls6/eEj2rl55H3XyPQ1ZsZlIpG6IVVgbc9mvVWm1kq
 WrHtGvzPLYtMXBNE0RBppLRL0+2l4TW23SRRFVpthoYaMg5kMV4CiYgCiOqvR8XZFjTu
 suQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=QhSVaQYJedSA+aBywG/Ib4vn4OqSeRDKiRI2SrKATuI=;
 b=NUFZD58Uh3PZfTfoV5hxO2ap0HsYTOJlKyhBw9KRvnrXLfNbNcWZq6/DryszAvydTv
 04tHaVCthn8zJmO5U6pRk6HcE4N9o/m0r2w+DvTR7kHcVnvpb0tYHVp4Cl7wfnoveU5J
 kfFDcImsPJf+LFvWTf94SUZ8JslhVPQ74OAEd9ioMchKKzATWJEza7EM1oXcMY7t5Q32
 vLXyBD66QiPxS2yKnxwuLx25ND1WmOgZJmMgde64b/oXrubWfUIA5fAGm5Z2LjNWKKAE
 lvOs9qcW5AkEJGWyTGUtdbB11qx/DwhgYOzYQZoFnPOu6MpTl0Yss19cXWa/DKFP0u+e
 YUiQ==
X-Gm-Message-State: AA+aEWY7Pk+2av6V6R5O4J4fHldbOUu5SqR+G4c0w6+OIrLOjbULOxrb
 WlnoXx9JhJIyi9Cq1HkrcBf/JA==
X-Google-Smtp-Source: AFSGD/Xr3A13sIjQXFIMIvb8VH9ppwfQDM7+S/4TMGelmTKM7+BOqjsb+jcXuzRXXQbncer9umAN4w==
X-Received: by 2002:a2e:6a13:: with SMTP id
 f19-v6mr15278163ljc.41.1544683900803; 
 Wed, 12 Dec 2018 22:51:40 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 15-v6sm166712lje.18.2018.12.12.22.51.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:39 -0800 (PST)
Date: Wed, 12 Dec 2018 22:48:03 -0800
From: Olof Johansson <olof@lixom.net>
To: Horia Geanta <horia.geanta@nxp.com>
Subject: Re: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
Message-ID: <20181213064803.kd7p7fzsegu6nhnl@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
 <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225153_441410_439D1659 
X-CRM114-Status: GOOD (  11.12  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBOb3YgMDksIDIwMTggYXQgMDY6MDU6MjRBTSArMDAwMCwgSG9yaWEgR2VhbnRhIHdy
b3RlOgo+IE9uIDExLzkvMjAxOCAzOjExIEFNLCBNYXJjIEdvbnphbGV6IHdyb3RlOgo+ID4gQ29t
bWl0IGU4MzQyY2M3OTU0ZSAoImVuYWJsZSBDQUFNIGNyeXB0byBlbmdpbmUgb24gUW9ySVEgRFBB
QTIgU29DcyIpCj4gPiBlbmFibGVkIENSWVBUT19ERVZfRlNMX0RQQUEyX0NBQU0sIHdoaWNoIGRl
cGVuZHMgb24gRlNMX01DX0RQSU8sCj4gPiB3aGljaCBpcyBub3Qgc2V0LiBFbmFibGUgRlNMX01D
X0JVUywgYW5kIGJ1aWxkIEZTTF9NQ19EUElPIGFuZAo+ID4gQ1JZUFRPX0RFVl9GU0xfRFBBQTJf
Q0FBTSBhcyBtb2R1bGVzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEdvbnphbGV6IDxt
YXJjLncuZ29uemFsZXpAZnJlZS5mcj4KPiBSZXZpZXdlZC1ieTogSG9yaWEgR2VhbnTEgyA8aG9y
aWEuZ2VhbnRhQG54cC5jb20+CgpJIGhhZCB0byByZWRvIHRoaXMgb25lLCBhbmQgd2hlbiBJIGRp
ZCBJIG5vdGljZWQgdGhhdCB0aGVyZSdzIGFsc28gYW4gZXRoZXJuZXQKZHJpdmVyLiBTaG91bGQg
dGhhdCBiZSBlbmFibGVkIGFzIHdlbGw/CgoKLU9sb2YKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
