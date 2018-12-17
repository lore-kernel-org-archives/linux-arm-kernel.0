Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459CFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:20:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014A52133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lsx+UAed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014A52133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=en/8kfnrbYs3mdujxGE9v0ZCJ7yt5nGFWriF8GQgk9k=; b=lsx+UAedWOr+oM
	3A6HdHym356Tbjjx75oiPmr5nxSLEgL5+EWuttIwdEcjUWYZOFR6ghnMeQSTC43UvQZs8JqoGTzNO
	COwspV7DXehmfZuyhYeSzuS+klQDPP2it/cZl8Px+L9sTXfmq0//q6yA1egEBx4ydYCMkbOXkY6cd
	g5zB/8lgdp69mb6B3ZFAGpMi9RUHS1mPGo/aNZ8/mhDtYj49bWy0GYWgdmT1dTUrTF8xT8bm4emgd
	yMXX5Oc89/V67MWAuNteRA2EeBJ+ZUb+Sr8VoUWXsDleEjx8xWh4mxO8FNH3nnrcfvOwfHia81dku
	Gm1VZJ21X7p+JieB8mfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtlH-00041k-CT; Mon, 17 Dec 2018 14:20:47 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtlD-0003vk-EO; Mon, 17 Dec 2018 14:20:45 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gYtkj-0004SQ-6g; Mon, 17 Dec 2018 15:20:13 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx9999@hotmail.com>
Subject: Re: [PATCH] dts: rockchip: rk3066: add qos_hdmi and HCLK_HDMI to pmu
 node
Date: Mon, 17 Dec 2018 15:20:12 +0100
Message-ID: <39618907.0447OVrsHf@phil>
In-Reply-To: <AM6PR04MB4504E587B100C217B4860380BFBC0@AM6PR04MB4504.eurprd04.prod.outlook.com>
References: <AM6PR04MB45048F404CB1166F7CEB0101BFA20@AM6PR04MB4504.eurprd04.prod.outlook.com>
 <CAAFQd5DrRRQku4jDn5sC+TornQjGi0U7W8UUiv29aQtCyxf=yQ@mail.gmail.com>
 <AM6PR04MB4504E587B100C217B4860380BFBC0@AM6PR04MB4504.eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_062043_633035_A2C84C2F 
X-CRM114-Status: GOOD (  21.38  )
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
Cc: Joerg Roedel <joro@8bytes.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Sandy Huang <hjc@rock-chips.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Sean Paul <seanpaul@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Johan,

Am Montag, 17. Dezember 2018, 15:00:55 CET schrieb Johan Jonker:
> Thanks Tomasz for adding all the mailing lists.
> I prefer to ask first if a qos_hdmi exists before sending it in for
> public review.
> 
> All the clocks in the pmu node seem to have a "quality-of-service" (QoS)
> block.
> So I added one for hdmi too with the question if it exists and which
> address it might have.
> SoC documentation still isn't fully public, not that I'm aware off.
> 
> From Heiko's response I learned that the rk3066 manual does
> not list any hdmi-related QoS blocks.
> We now only add the HCLK_HDMI clock to pmu node in our patch.
> 
> After a small step forward people immediately ask to do a real patch serie.

Of course :-D .
Collecting reviews can take time, so posting things early is helpful,
especially now that you actually can generate output.

That is the one requirement I have ... that things actually work and
the vop-driver alone didn't look that way some weeks back ;-)
[And as we found out was also missing the changed irq].

> The rk3066_hdmi.c file also handles audio, but this is not tested yet.

You can strip the audio parts from the hdmi-encoder and just submit
it with the display parts only.

That way we can possibly pick up the working things already, reducing
the number of patches you have to carry around ;-) .

> The rk3066a-rayeager.dts file gives a idea how it's done,
> but I haven't had the time to get it working with .config and dts.
> Let me know if you can.

I think making this actually work will fall on your shoulders.
I.e. the rk3066 is really old (from 2012 or possibly even earlier), so
people like Tomasz don't have access to this (and also in most cases
not the time or interest to work on those specific socs).

While I do have a rk3066 marsboard here, it is currently not functional
in my test setup, so I also can only look at the code you provide.


Happy hacking
Heiko


> On 12/17/18 6:46 AM, Tomasz Figa wrote:
> 
> > Thanks for the patch. Unfortunately, it looks like you didn't add the
> > necessary mailing lists to the recipient list. For reference, the
> > ./scripts/get_maintainer.pl script in the kernel source tree should be
> > able to give you a reasonable recipient list. For now, I added the
> > mailing lists on CC and replied without snipping, so people should be
> > still able to review the patch.
> > 
> > Other than that, It looks reasonable to me, but we need someone with
> > access to SoC documentation to check it. Heiko, Sandy, is that
> > something you would be able to help with?
> 
> 





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
