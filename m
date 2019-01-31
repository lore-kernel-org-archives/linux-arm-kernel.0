Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:03:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB6A20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SSQMIQKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB6A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ccb3oe/w0+RENO42bFy6UsfRdE/VDMY/cHVVxaLyLCU=; b=SSQMIQKyL7w5sA
	hlvKzYeYS69xplDg8DGkuDsmutTnRcWwOafChI6euRmkynFA5vFUhTwZoz8G2DshOAGPGx+gn+bvI
	CuuCqiRRJIJbxekqTkbeuQAZFer8JlYljB8MuhwhKzWIGM6gxiWYoO71lYZtjVPzhUYNVZ1LWnw2x
	dFXJiYA/f3oia7FA2QL1kUyFSpSiUVpzC8ubk0AwV2/Q0+ZaqQBR5CXREjvt42M/wFek2ZuhvR/Lb
	ImH4qiHu6HtmxIh1rskyRyywmis3E9ZJ9A85InAsHZqtuXDIcgpsoETz4moVbY0tjvJAoTwo84dci
	Bzalrvm8Dwss37YUB1EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCwB-0005o8-An; Thu, 31 Jan 2019 14:03:27 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCw5-0005nF-V1; Thu, 31 Jan 2019 14:03:24 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id 5CFD127FEAC
Message-ID: <ef348923cfbd18a2566ec0e3d6af3d75b46c32aa.camel@collabora.com>
Subject: Re: [PATCH 0/4] WIP: rockchip mpp for v4l2 video decoder
From: Ezequiel Garcia <ezequiel@collabora.com>
To: ayaka <ayaka@soulik.info>, linux-media@vger.kernel.org
Date: Thu, 31 Jan 2019 11:03:06 -0300
In-Reply-To: <20190131031333.11905-1-ayaka@soulik.info>
References: <20190131031333.11905-1-ayaka@soulik.info>
Organization: Collabora
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_060322_255374_B3BA247D 
X-CRM114-Status: GOOD (  21.86  )
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
Cc: hverkuil@xs4all.nl, acourbot@chromium.org, maxime.ripard@bootlin.com,
 joro@8bytes.org, randy.li@rock-chips.com, linux-kernel@vger.kernel.org,
 jernej.skrabec@gmail.com, nicolas@ndufresne.ca, paul.kocialkowski@bootlin.com,
 linux-rockchip@lists.infradead.org, thomas.petazzoni@bootlin.com,
 mchehab@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hey Ayaka!

On Thu, 2019-01-31 at 11:13 +0800, ayaka wrote:
> From: Randy 'ayaka' Li <ayaka@soulik.info>
> 
> Hello
>   Those patches are based on the previous vendor driver I post before,
> but it can apply without the previous one.
>   I really want to make it work before FOSDEM and I didn't. And upcoming
> the lunar new year holiday would last two week.
> 
>   I have verified the v4l2 part but I meet a problem with power or
> clock, it would be a complex problem, I would handle to solve it after I
> am back. But I just tell my design on this kind dirver.
> 

This the branch I'm about to submit:

http://git.infradead.org/users/ezequielg/linux/shortlog/refs/heads/vpu-mpeg-2-almost-ready-for-upstream

And it has no power issues. Perhaps you can take a look inside,
you might be just missing a few pm_ statements? Perhaps a devicetree thing?

> A few questions I think you may ask I would like to answer it here.
> 

I have another question: is this patchset meant to support for mpeg-2
decoding only? I can't find any other codec code.

Thanks,
Ezequiel

> 1. Why it is based on the previous vendor driver ?
> The vendor driver I post to mail list is a clean version which having a
> efficient work flow and those platform dependency controls having been
> merged into it.
> 
> For the stateless device, V4L2 is just another interface for userspace
> to translate it into registers.
> 
> 2. Why use a structure to store register infomation not marco ?
> I really don't want to define many marcos for a device having more than
> a hundred of registers. And there are many fields in a registers.
> 
> For the VDPU1/VDPU2 which would support more than 10 video codecs, these
> two devices would re-use many registers for many codecs, It would be
> hard to show the conflict relations between them in marco but more easy
> with C union and structure.
> 
> BTW, I would prefer to write a number of registers into the device
> though AHB bus not just generate one then write one, you can save some
> times here.
> 
> 
> Besides the two previous answers. I really have a big problem with v4l2
> design. Which would driver wait the work of the previous picture is
> done, leading a large gap time more idle of the device. 
> 
> I am ok the current face that v4l2 stateless driver is not stateless.
> But it would limit the ability of stateless decoder. It is more flexible
> to those videos having different resolution or orientation sequences.
> 
> But I don't like the method to reconstruct the bitstream in driver, it
> is a bad idea to limit what data the device want. Those problem is
> mainly talking in the HEVC slice thread. And it was ironic for the VPx
> serial codec, which mixed compressed data and umcompress header together
> and twisted. Even for the ITU H serial codec, it would become a problem
> in SVC or Google Android CTS test.
> 
> And thanks kwiboo, ezequielg and Paulk, I copy some v4l2 code from their
> code.
> 
> Randy Li (1):
>   staging: video: rockchip: add video codec
> 
> ayaka (3):
>   [WIP]: staging: video: rockchip: add v4l2 common
>   [WIP] staging: video: rockchip: vdpu2
>   [TEST]: rockchip: mpp: support qtable
> 
>  drivers/staging/Kconfig                       |    2 +
>  drivers/staging/Makefile                      |    1 +
>  drivers/staging/rockchip-mpp/Kconfig          |   54 +
>  drivers/staging/rockchip-mpp/Makefile         |    8 +
>  drivers/staging/rockchip-mpp/mpp_debug.h      |   87 ++
>  drivers/staging/rockchip-mpp/mpp_dev_common.c | 1365 +++++++++++++++++
>  drivers/staging/rockchip-mpp/mpp_dev_common.h |  215 +++
>  drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c |  878 +++++++++++
>  drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c  |  755 +++++++++
>  drivers/staging/rockchip-mpp/mpp_service.c    |  197 +++
>  drivers/staging/rockchip-mpp/mpp_service.h    |   38 +
>  drivers/staging/rockchip-mpp/rkvdec/hal.h     |   53 +
>  drivers/staging/rockchip-mpp/rkvdec/regs.h    |  395 +++++
>  drivers/staging/rockchip-mpp/vdpu2/hal.h      |   52 +
>  drivers/staging/rockchip-mpp/vdpu2/mpeg2.c    |  253 +++
>  drivers/staging/rockchip-mpp/vdpu2/regs.h     |  699 +++++++++
>  16 files changed, 5052 insertions(+)
>  create mode 100644 drivers/staging/rockchip-mpp/Kconfig
>  create mode 100644 drivers/staging/rockchip-mpp/Makefile
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_debug.h
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_common.c
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_common.h
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_service.c
>  create mode 100644 drivers/staging/rockchip-mpp/mpp_service.h
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/hal.h
>  create mode 100644 drivers/staging/rockchip-mpp/rkvdec/regs.h
>  create mode 100644 drivers/staging/rockchip-mpp/vdpu2/hal.h
>  create mode 100644 drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
>  create mode 100644 drivers/staging/rockchip-mpp/vdpu2/regs.h
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
