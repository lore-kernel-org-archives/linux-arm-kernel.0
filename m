Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E47C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:49:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60762145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E739xYov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60762145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=awkeD/HG4t7NTSkqmOoLgwulgtyc6Mg+1f+UcfUldsM=; b=E739xYovZ++Zpq
	vKt732rrXfmGBDDPxoytmk6Q8Hd42gw8OpJnhTBvCsyJ/D5xEstt3hNn4iWV525mFc26ZrdpD9a2i
	0amF5NQdV88H6AbfPnBWUdSHHPtIh3/vO/dlwyv6IRTApHpdGh3LcIAj/o7X8Y58/qMEhxC8DnBoZ
	CmSpL2T08xVAN9/AU6GuO1EjritKyBqQgqLVpVNwXHN6KQykxv5UPYBHzse/4gs0GkzYcGTdMouEq
	hcTWfQJZWoriLcTTLivOGyVFQSpRk6ZFiIB3BOI/IetmoOGfmrrctBTLe8NjvU3uJ8cVDOZra2YRE
	zxnPGqWENtoW92uOLxgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkqa-0008Tp-3n; Mon, 03 Dec 2018 09:49:00 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkqX-0008S6-8B
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:48:58 +0000
Received: by mail-ed1-f68.google.com with SMTP id j6so10126572edp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aMmI4PWI3/oxD5mPfhnmHTJzwbj8cjFnmjKPIvkUVWg=;
 b=ZelLhWPXLchRPliz6iVIWQbaMLoUGt6Ndq72XrvTbUk1++fuVhhuhd3mS7uiKE9xd9
 Owbq9uwPlKAZqshztiBXUv1Tdd65mGE35GlO8t9kzDb3XsHwGIHQtV2GZ3dlEUpaPOih
 AvqpMopgGGybNnGvR7gU7gvkOvfl6NiPhY8jblk7xXm96TjMImoxYCvNRTOczcwvW4Uu
 nQT8p+q/kRIfwqxKjitkbUKqh4pFwqMA3dMJUzA7BjiKAtUXd1gHIu3nD2bK5Bwe7Y9l
 lSBSJXGUtKr3Mckcpa0MZOtAKWvzUSJLbCmfdz2ALCyz/dqtZ73KU2z4PoDCeBzrdrb2
 xo3w==
X-Gm-Message-State: AA+aEWabmNJOLRYAqsHoR/mKxGO8CQJT7Lj4oQaDYRaHHCfa970EjjZU
 ll/WcFw6F1iE/FRKS64QwjVnRfw+U04=
X-Google-Smtp-Source: AFSGD/X6qaANGYZS0tzuI7WkZAWgmFqs5bTDyoRvpt+LtCg7CiDZFmq1zWTbr5Fwau+TTsBYTyakwQ==
X-Received: by 2002:a50:ba3d:: with SMTP id g58mr14154223edc.35.1543830525386; 
 Mon, 03 Dec 2018 01:48:45 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com.
 [209.85.221.44])
 by smtp.gmail.com with ESMTPSA id z2sm3754644edd.4.2018.12.03.01.48.44
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 01:48:45 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id v13so11387513wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:48:44 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr12714638wrv.87.1543830524486; 
 Mon, 03 Dec 2018 01:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-2-wens@csie.org>
 <CAMty3ZC-4hnVOx9AYhm7uUCUHF=n_NoH3xV-3SyUXWxb_X8TGg@mail.gmail.com>
In-Reply-To: <CAMty3ZC-4hnVOx9AYhm7uUCUHF=n_NoH3xV-3SyUXWxb_X8TGg@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 17:48:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v67xoqV+QuVxDyBrUzzpab9vsbJRQBFPA0OS=h_bZ2H7Tw@mail.gmail.com>
Message-ID: <CAGb2v67xoqV+QuVxDyBrUzzpab9vsbJRQBFPA0OS=h_bZ2H7Tw@mail.gmail.com>
Subject: Re: [PATCH 1/6] media: dt-bindings: media: sun6i: Separate H3
 compatible from A31
To: Jagan Teki <jagan@amarulasolutions.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_014857_292931_DDB7FC55 
X-CRM114-Status: GOOD (  16.24  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 5:42 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > The CSI controller found on the H3 (and H5) is a reduced version of the
> > one found on the A31. It only has 1 channel, instead of 4 channels for
> > time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> > "fallback" to a compatible that implements more features than it
> > supports.
> >
> > Split out the H3 compatible as a separate entry, with no fallback.
> >
> > Fixes: b7eadaa3a02a ("media: dt-bindings: media: sun6i: Add A31 and H3
> >                       compatibles")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> "media" text appear two times on commit head.

Just following what previous commits did. :)

> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

BTW, I know you've been trying to get CSI to work on the A64.
I have it working for the Bananapi-M64. The CSI SCLK needs to
be lowered to 300 MHz or the image gets corrupted.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
