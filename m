Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED56C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:45:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D676218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H5KTwxTa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcxZRl9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D676218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wmgp6NpEIY+6hoOR/owMxbgEuMJ4Xso6UPaPgbtX2pc=; b=H5KTwxTa6P4oXN
	dPf0zzpwX6Eq/OQKi1aN934mUIKIswROTZ86a7FCOnEQXTlBUR/EzpiBRFzh9fAfTy7cMo+rzu99w
	/+UIpxXLuwL8Jl8mHxQ5N2klzZPQ+r9hN0RNsgi7x+cAj98WiPfcFNJ9pnXiLT28bWNTz+snpHXxv
	nEejXtQ5Ptpm22cOxXciZGYukKOH2UDPL9Hxnpn4nBpSMXQQy7JpVwiLSREZC9K8bhjtm2OWw+SJf
	x0zsEv0mZv0oNIph1enI2Zs9UY90zXvdl+gVem+eY2WhRtjVUJGtwetRClPpH26Zzv9nGjUHYRFKQ
	2HhZy/I9a+aorJ8yzL7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtJOZ-0004WK-2k; Mon, 11 Feb 2019 21:45:43 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtJOW-0004Vj-Ix
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 21:45:41 +0000
Received: by mail-ot1-x341.google.com with SMTP id 32so700217ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 13:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TvJTjYaxolvqzPx0RriFxydTkL+133X2/ADxdqWjRsI=;
 b=fcxZRl9Xot1WCOhujy/uLeOPkyEZOQ8ZqwYSFBr8DUfxbniMDRU5jbp5Hn43IcYDZP
 0VYCziykOUbt7FImbUGksmg8Y1UTQnwSQ+lynP/osV+0Hoq7v0fQoFFT+XuZBXgNSLOu
 CbcvnmossN2w2q0Kt9KtrBFqfG0STgHDQSA1KvTSFzUJmy/SE3zkPjA515vN3bLj1oTF
 uRLVp0uTcQoNo2ItBplhU4b975nVSAeSshgybhK9LotuREFuC6v3hEH53rlun/zWGoms
 fyFIFderxm6y8symZjB5JvS8YCHWJms0/U5gUCkte81u0F8VbR6tqzezzbaRfj3FMa+H
 PkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TvJTjYaxolvqzPx0RriFxydTkL+133X2/ADxdqWjRsI=;
 b=cVQ/tdrTmEfk6NAKkqw9qmOfqAytD5nQLj/2Siq3Ry50pk5EyQtNVmlgAm8Orj0Ch5
 ta7ff2nhIsbi9xQoAxs36vrBPdwt5gHK8K8iLFRSt6R65erqP91zlh1er6jrNvHXOUF9
 /Wx9294dljcGfFhHXZQkEO+b1YJBm1QhCE+XMsQCajxZqEzt+gPG9bs2IDZQ1PdngJV+
 TkXnL+GwlNOckFTRHL7OjFHrkeShUT5WokiEJ45ihayMCKVSUgfh7rJnTBOIGpO6IOgc
 dPiY8pc/T6/wP4rIjk7ashh0PkXz5LWkC6tFNUSiz94O6p8ZXZekbe6xK5WI1QVf3Q1B
 JI5w==
X-Gm-Message-State: AHQUAuYOWXsSWs2h3zkYFUhiUM35BDBHn6GHft3rjItt53Oo90AfQJ51
 B9kku4ItCV/luqhSvuxqCp01XzZWStFLeqlY5aw=
X-Google-Smtp-Source: AHgI3IahSLbbvcDIrM1qoAaA6Pw/SgyEjZxs/1l1kaVWSv4N0UbxLlJZih7eHgV8gdYujJvhub8wuD2NKIp0IToUyNM=
X-Received: by 2002:a9d:64c8:: with SMTP id n8mr362883otl.115.1549921538668;
 Mon, 11 Feb 2019 13:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20190211110744.3621-1-u.kleine-koenig@pengutronix.de>
 <20190211110744.3621-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190211110744.3621-2-u.kleine-koenig@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Feb 2019 19:45:27 -0200
Message-ID: <CAOMZO5CiT7gfmeFfK5oFvv=Ea4sTrE8xnHdr9RoOPpoS3PGGDw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: Add devicetree for Eckelmann CI4x10
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_134540_652148_217A9778 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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
Cc: Gavin Schenk <g.schenk@eckelmann.de>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTEsIDIwMTkgYXQgOTowOCBBTSBVd2UgS2xlaW5lLUvDtm5pZwo8dS5rbGVp
bmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKPgo+IFRoaXMgaXMgb25lIG9mIHR3byBi
b2FyZHMgdGhhdCBtYWtlIHVzZSBvZiB0aGUgcmVjZW50bHkgaW50cm9kdWNlZCBTSU9YCj4gYnVz
LiBBcGFydCBmcm9tIHRoZSBkZXZpY2VzIGRlc2NyaWJlZCBpbiB0aGUgZHRzIGl0IGZlYXR1cmVz
IGEgZGlzcGxheQo+IHdpdGggdG91Y2ggdGhhdCBJIGRpZG4ndCBpbmNsdWRlIGhlcmUgYmVjYXVz
ZSBpdCBuZWVkcyBzb21lIG5vbi1tYWlubGluZQo+IGNoYW5nZSB0byBvcGVyYXRlIGNvcnJlY3Rs
eS4KPgo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdA
cGVuZ3V0cm9uaXguZGU+CgpSZXZpZXdlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21h
aWwuY29tPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
