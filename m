Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9396C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:07:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEF4217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fORH7MzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEF4217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nJlWCnTZF04Er/58Hd6Y0GuuRZsf2A3blB7E2B0ugMI=; b=fORH7MzHiVUYUs
	gjs8dZHMYqAiYfKORPzIGtiV9h0zeAF589QY2Sjz5rmoxDuLhgRjb7Xtdh8bIVBpA5qrdrFMjtVVK
	98+wn4xZbIYPfMPlQ/i83AlPXGGDF1NRY0G4mue7HCtfm839oOv2x1pnbjGZVCZSYWUcS2rFNlUDU
	/56MVbItd4pMa9CBj3tUT5mfJzUaCc8PDs/fQzIDRj7r1zcnaBbjcUkoorbU0EqIDTDoTH2fQB2tU
	N/JAUxb162Mmku2canUoAehoTh79hGTyAd0//rQvZW7QSWg6fiEvPZp2YpeGkeVgVlyExYWxJd9wk
	9YU81qtWQkHM6BXgAvog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbun-00009q-4g; Thu, 24 Jan 2019 10:07:17 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbuk-00009S-9l
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:07:15 +0000
Received: by mail-ed1-f67.google.com with SMTP id o10so4059338edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 02:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qBmEZzVOX/SIzMHv3rv0lFTIcGaNCblyNlW68laj+hI=;
 b=k3twh8TKfKdiSeFcmlllOeel+JYbz6fnKkO6l+bkbZXNKZl2+xzME7/KUy5k7uuucm
 S3Dv/mAqhbcXAo+9ODZ6CaV1UeiMtr0SQUQLfH0LmP2QWFmTn7y9WUUXey+XFbc9n6w+
 4Oa8vUJFX3a4yxL7VZ7kWRy1UaOZOGPwgMvwDtfMdB9nJAJO8akQNqYJcMsrNDI7auyS
 Ro7AyTzKkh+xSd5+yg2/hFWuaGPPWMfGSY6dTYVWxi1c19mRFsTfcDza5NTHZzFfu+Pk
 y/XI9CAwV207xIHInczJsIQIXBty8zq/pH9ma7M0udhWAih+gdALsfNo+aBDHdArcuR5
 mBTw==
X-Gm-Message-State: AJcUukeV2OkYkBf9paIC2IZDMcQyYKyFpl0dTw4MI1VCK9KXgnPSjryD
 gqSyML+pXi63yOOkwKhFUGYWgNMvlGI=
X-Google-Smtp-Source: ALg8bN641FnxgSfOLvhwxgep3re9V2jdimzbYps3Wt3dZOZSmXsXt/9UIze72lrN3FcUel2hHbc8Zg==
X-Received: by 2002:a17:906:258f:: with SMTP id
 m15-v6mr5526162ejb.191.1548324432333; 
 Thu, 24 Jan 2019 02:07:12 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
 [209.85.128.50])
 by smtp.gmail.com with ESMTPSA id b46sm10926199edd.94.2019.01.24.02.07.11
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 02:07:12 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id a62so2445097wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 02:07:11 -0800 (PST)
X-Received: by 2002:a1c:494:: with SMTP id 142mr1938306wme.111.1548324431473; 
 Thu, 24 Jan 2019 02:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20190113021719.46457-1-samuel@sholland.org>
 <20190113021719.46457-3-samuel@sholland.org>
In-Reply-To: <20190113021719.46457-3-samuel@sholland.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 24 Jan 2019 18:06:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v65H_ZBMFY_c86acSxX96wFC=0_p_H2x+vzio4-ATayHHQ@mail.gmail.com>
Message-ID: <CAGb2v65H_ZBMFY_c86acSxX96wFC=0_p_H2x+vzio4-ATayHHQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 2/2] arm64: dts: allwinner: a64: Enable
 A64 timer workaround
To: Samuel Holland <samuel@sholland.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_020714_338251_079CE034 
X-CRM114-Status: GOOD (  10.99  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 13, 2019 at 10:17 AM Samuel Holland <samuel@sholland.org> wrote:
>
> As instability in the architectural timer has been observed on multiple
> devices using this SoC, inluding the Pine64 and the Orange Pi Win,
> enable the workaround in the SoC's device tree.
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied for 5.1.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
