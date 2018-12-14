Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA08C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:24:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B09220879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kx10fQUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B09220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=//Vv0OIcpQBnzbs9Sw3y8xaKXVKSuPjxPNqjTwJPiP4=; b=kx10fQUA4WBooe
	3x3ake+OCzjCbKo5N49tgKZyd87Ai0s8tWnZmXLBYd3gPXFgjIE9hbdDidPYe/X9RD/8nf9/EF7Su
	StjWd4PJS3Tg8Paz8sY1FKRVoh4xqyHYKARhHUkrqVS0200CJErwbQlGmeZvtzb9rDPuir5PvxsNH
	/uk40EBHmssxy9jcuNnM40+0It34bEJllxlt8Z7hhm9eU0JjZyvY614btXKbUM3HgdTNdDTBDmUwP
	WkSYFlhg6ab8oLW1lqIv3zrY58IEpH4DDQwfyxMUCCrKd7YrSIylNcgg/oV5lg51ot8QbJG5oeHhl
	od8neTc4MmVFMEfeQ76A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXd9F-0008Lt-2M; Fri, 14 Dec 2018 02:24:17 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXd9B-0008Jq-JQ
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 02:24:15 +0000
Received: by mail-ed1-f68.google.com with SMTP id b14so3717714edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 18:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WrNL09/DBqFQdRHyvLiqUAfyU2rTzrkrVarVXUnajTc=;
 b=Bp3mjJUG2M+8MKKiNQhcIt63FZBQJeEqnlUo5lFmXTyW/frf8vm5zvS3EXeOfvoINd
 llmLHI1Q8B9w+xb4u5ZGp3zYiBdg4072pbjlAPeLaOR40f0GvRTdN2bSBZGCJemuoXDJ
 0zFg2WyJ7pC+bc/EDKo95O+Qh3b+9S4hqZp2+iL57gAR9GiKwuiNhpMTLRiUG5IRx2Y1
 vL/FtjiF6agTLAh5IFdDGO6/7OTMDnwSzsBpN3QFEz/HUx6obtSJcvIDItAm0x+sernY
 eom5Do7Us+bnCi/caVJE+1eRqkzxxkiFZj0hJHJRPvdlQa46D2ftsjFH0+nO59SHuAFm
 Lw6Q==
X-Gm-Message-State: AA+aEWZNevmHEGZa5W90I0NjL4cOU6vyoJ1xtk0LXpQ3EOIgnssEotVH
 eKSvLrcVzNGNbzGwVk9XDaNXRBMJ8GA=
X-Google-Smtp-Source: AFSGD/WeHXcae9iq4/+799HQvLGQGf5pwjS+/Xue0KSp64IZ2E3+gA6PYu8tPJDd3nNCPUKJ2DpG1A==
X-Received: by 2002:a50:ed03:: with SMTP id j3mr1379076eds.134.1544754239891; 
 Thu, 13 Dec 2018 18:23:59 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com.
 [209.85.221.54])
 by smtp.gmail.com with ESMTPSA id z9sm1185427edr.61.2018.12.13.18.23.58
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 18:23:59 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id z5so3929398wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 18:23:58 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr1018504wrv.188.1544754238556; 
 Thu, 13 Dec 2018 18:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181213221030.f7c5mzuyke3ik43r@valkosipuli.retiisi.org.uk>
In-Reply-To: <20181213221030.f7c5mzuyke3ik43r@valkosipuli.retiisi.org.uk>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 14 Dec 2018 10:23:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v675OQ6CQLr3Gzjd6yN-wkfB=ZfttgtTceN5AD2EXo2YEw@mail.gmail.com>
Message-ID: <CAGb2v675OQ6CQLr3Gzjd6yN-wkfB=ZfttgtTceN5AD2EXo2YEw@mail.gmail.com>
Subject: Re: [PATCH 0/6] media: sun6i: Separate H3 compatible from A31
To: sakari.ailus@iki.fi
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_182413_645662_15C53AFB 
X-CRM114-Status: GOOD (  21.29  )
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

On Fri, Dec 14, 2018 at 6:10 AM <sakari.ailus@iki.fi> wrote:
>
> Hi Chen-Yu,
>
> On Fri, Nov 30, 2018 at 03:58:43PM +0800, Chen-Yu Tsai wrote:
> > The CSI (camera sensor interface) controller found on the H3 (and H5)
> > is a reduced version of the one found on the A31. It only has 1 channel,
> > instead of 4 channels supporting time-multiplexed BT.656 on the A31.
> > Since the H3 is a reduced version, it cannot "fallback" to a compatible
> > that implements more features than it supports.
> >
> > This series separates support for the H3 variant from the A31 variant.
> >
> > Patches 1 ~ 3 separate H3 CSI from A31 CSI in the bindings, driver, and
> > device tree, respectively.
> >
> > Patch 4 adds a pinmux setting for the MCLK (master clock). Some camera
> > sensors use the master clock from the SoC instead of a standalone
> > crystal.
>
> I've picked patches 1 and 2, but I presume patches 3 and 4 would go through
> another tree. Is that right?

We'll merge patch 3 through the sunxi tree, probably as a fix for 4.21-rc.
Maxime has said that pinmux settings won't be merged unless there are actual
users in tree, so patch 4 won't be merged for now.

Thanks!
ChenYu

>
> >
> > Patches 5 and 6 are examples of using a camera sensor with an SBC.
> > Since the modules are detachable, these changes should not be merged.
> > They should be implemented as overlays instead.
> >
> > Please have a look.
> >
> > In addition, I found that the first frame captured seems to always be
> > incomplete, with either parts cropped, out of position, or missing
> > color components.
>
>
> --
> Regards,
>
> Sakari Ailus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
