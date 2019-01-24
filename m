Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6076C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:17:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64B0218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oKzfh+8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64B0218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MeQ883hRFyZl5stIOzSvJMQZ0iA5PwqVi6I0KzdDOrQ=; b=oKzfh+8R2VP0kD
	Dfai/lm1TMRLKZ26gJXu76X2abPWb7+3RnHo5HZZZxVsqLCY5tXdE83zcqCMPz8xqn4mWPxbX4BZ0
	juftFecLb/ofow3BdhqQjo7Q8hHahJTQh+WevLHTanSZJ+kobWgMAnWPTcD2IaPUI0D+I98GsqRc4
	WD8kput/iJMRprO8hG2QUGCZv5lpXXt9PMLVmSDHOa+bsD8VyBaD3r2ID/PErwZtr8eiDKjPcLVtE
	L+nqAVVV+T6a5uLDOBihLZG74E2dMBBtV49HCURB7ytWQfg13kWqS3/WGXDz4ibJMcXQDqXv5v72q
	TAm6xhPvSzYZi07kKvog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmc4T-0004gc-NQ; Thu, 24 Jan 2019 10:17:17 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmc4O-0004fD-3E
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:17:15 +0000
Received: by mail-ed1-f68.google.com with SMTP id y56so4092544edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 02:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QrS7sDgTK/p6WIKMEMFfTtaoUcPIzsYu3/wEQPiXjgs=;
 b=BmgoNuULOtcjatU+Z4lOKvchp4zmK1qGvPPzUmDQ+XrE1u906WUUEODHPTU46/Pgic
 a8WbnCW7dPLEvrTK2OwJpgeDLa8TH6Nb4BYfAFKaIJnWmXGMs/shUKnDNVKgPKEYO8e7
 SfcczdsASRa9MOkOfCMv/Oo11Bjjdld8nu4kedzQWV1v0QoRap3aXwEjRUCVG801l9ch
 hXUPAjAG6+HJuVigQYCD6MU/z2zQMD5zccj1lH61AjbOeDWY4FFWvm0EqI/lN34WnIf9
 HcJwK3r2wCAgsuThtFBki48Ka3ggHkIBfBc0DN/PJJ/ItdTIzhJdknowz5PMQvfl6vP9
 1LNQ==
X-Gm-Message-State: AJcUukclmhvtkKhrtpuaqAtz/GsDA/RUomNoSXy5W+Jl9hFLto9kmw1+
 lzsaqsOMgGl+iIF/N2XJA1/YdhL6xm8=
X-Google-Smtp-Source: ALg8bN5lcAtHw4bBTjVUYErsOeS4Ler8Y+w/2lV9LpDZnYQaypOa+Dl1UNIQTpksABb/ZVe+4GBiZA==
X-Received: by 2002:a50:a826:: with SMTP id j35mr6231617edc.230.1548325029640; 
 Thu, 24 Jan 2019 02:17:09 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41])
 by smtp.gmail.com with ESMTPSA id p16-v6sm5977117eju.73.2019.01.24.02.17.08
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 02:17:09 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id z5so5787309wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 02:17:08 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr6254579wrv.87.1548325028586; 
 Thu, 24 Jan 2019 02:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-5-wens@csie.org>
 <CAMty3ZB6p8Uv7abMC8jDHHYwdAeuBen2GPjOhN=wEL7+=DDt3g@mail.gmail.com>
In-Reply-To: <CAMty3ZB6p8Uv7abMC8jDHHYwdAeuBen2GPjOhN=wEL7+=DDt3g@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 24 Jan 2019 18:16:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v67nAGC0xwgtq+_mYv_ZRmhBQsPdLbbJ6thfKDNY456sYg@mail.gmail.com>
Message-ID: <CAGb2v67nAGC0xwgtq+_mYv_ZRmhBQsPdLbbJ6thfKDNY456sYg@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: dts: sunxi: h3-h5: Add pinmux setting for CSI
 MCLK on PE1
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_021712_176151_AAF7B8E6 
X-CRM114-Status: GOOD (  17.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 5:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Nov 30, 2018 at 1:28 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Some camera modules have the SoC feeding a master clock to the sensor
> > instead of having a standalone crystal. This clock signal is generated
> > from the clock control unit and output from the CSI MCLK function of
> > pin PE1.
> >
> > Add a pinmux setting for it for camera sensors to reference.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
>
> On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > The CSI controller found on the H3 (and H5) is a reduced version of the
> > one found on the A31. It only has 1 channel, instead of 4 channels for
> > time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> > "fallback" to a compatible that implements more features than it
> > supports.
> >
> > Drop the A31 fallback compatible.
> >
> > Fixes: f89120b6f554 ("ARM: dts: sun8i: Add the H3/H5 CSI controller")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

Not merging this one, as there are no boards in tree that directly use this.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
