Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B378C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:53:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2FC2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RBC/mZXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2FC2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XKdUnXs48VeS9j8NrZS8BSIal82FCZ3ywhfkvkjMXwQ=; b=RBC/mZXZhXS79E
	yQ+vy+nGR2eqdTOb647QIzPxyL5yNtta2BOpgrKF1z+5ecXXcbRxBbEljjr5+TvbAmixeHU8mGICi
	q9dlA/ZTjFm35E2mwozOO+oSOcp5Kb+I4vPv8EGoZY4Oo/MhXP5Uk6Eu4xkOtNFyOSD2eBXc2dGgj
	MPt/C5U/sD3UqNF8G/f/WO3v2GKLMxhLm+4AqL9yj3s8k8IX4luwyEftPuVGAZs2HA/BhWNsOg76P
	GxFQXrqLG5qHpNEFdfto1ApSYUyafmcHrLMMKpjWcvROgd2PhWwWjwSFk0K2NyeuQc4+UrEt6HjsI
	PcZm6JNmA0rfvBf2RWVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxQD-0002p6-Vf; Tue, 05 Feb 2019 09:53:41 +0000
Received: from hillosipuli.retiisi.org.uk ([2001:1bc8:1a6:d3d5::81:2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxQ9-0002oU-De
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:53:40 +0000
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk
 [IPv6:2001:1bc8:1a6:d3d5::80:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 3172B634C7E;
 Tue,  5 Feb 2019 11:52:15 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
 (envelope-from <sakari.ailus@retiisi.org.uk>)
 id 1gqxOq-0002yA-5i; Tue, 05 Feb 2019 11:52:16 +0200
Date: Tue, 5 Feb 2019 11:52:16 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: compile error at sun6i_video
Message-ID: <20190205095216.f2fg5vjvqqhgs6as@valkosipuli.retiisi.org.uk>
References: <878syukax3.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878syukax3.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_015337_837055_EBBFF93C 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Yong Deng <yong.deng@magewell.com>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Morimoto-san,

On Tue, Feb 05, 2019 at 03:38:29PM +0900, Kuninori Morimoto wrote:
> 
> Hi MultiMedia ML
> 
> I got below compile error at SH.
> 
>   ...
>   CC      drivers/tty/tty_io.o
> /opt/RB02197/home/morimoto/save/WORK/linux/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c: In function 'sun6i_video_start_streaming':
> /opt/RB02197/home/morimoto/save/WORK/linux/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c:141:29: error: passing argument 1 of 'media_pipeline_start' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   ret = media_pipeline_start(&video->vdev.entity, &video->vdev.pipe);
>                              ^~~~~~~~~~~~~~~~~~~
> In file included from /opt/RB02197/home/morimoto/save/WORK/linux/include/media/media-device.h:26,
>                  from /opt/RB02197/home/morimoto/save/WORK/linux/include/media/v4l2-device.h:24,
>                  from /opt/RB02197/home/morimoto/save/WORK/linux/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c:10:
> /opt/RB02197/home/morimoto/save/WORK/linux/include/media/media-entity.h:1030:84: note: expected 'struct media_pad *' but argument is of type 'struct media_entity *'
>  __must_check int media_pipeline_start(struct media_pad *pad,
>                                                                                     ^  
> /opt/RB02197/home/morimoto/save/WORK/linux/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c:205:22: error: passing argument 1 of 'media_pipeline_stop' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   media_pipeline_stop(&video->vdev.entity);
>                       ^~~~~~~~~~~~~~~~~~~
> In file included from /opt/RB02197/home/morimoto/save/WORK/linux/include/media/media-device.h:26,
>                  from /opt/RB02197/home/morimoto/save/WORK/linux/include/media/v4l2-device.h:24,
>                  from /opt/RB02197/home/morimoto/save/WORK/linux/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c:10:
> /opt/RB02197/home/morimoto/save/WORK/linux/include/media/media-entity.h:1055:44: note: expected 'struct media_pad *' but argument is of type 'struct media_entity *'
>  void media_pipeline_stop(struct media_pad *pad);
>                           ~~~~~~~~~~~~~~~~~~^~~
> /opt/RB02197/home/morimoto/save/WORK/linux/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c: In function 'sun6i_video_stop_streaming':
> /opt/RB02197/home/morimoto/save/WORK/linux/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c:229:22: error: passing argument 1 of 'media_pipeline_stop' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   media_pipeline_stop(&video->vdev.entity);
>                       ^~~~~~~~~~~~~~~~~~~
> In file included from /opt/RB02197/home/morimoto/save/WORK/linux/include/media/media-device.h:26,
>                  from /opt/RB02197/home/morimoto/save/WORK/linux/include/media/v4l2-device.h:24,
>                  from /opt/RB02197/home/morimoto/save/WORK/linux/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c:10:
> /opt/RB02197/home/morimoto/save/WORK/linux/include/media/media-entity.h:1055:44: note: expected 'struct media_pad *' but argument is of type 'struct media_entity *'
>  void media_pipeline_stop(struct media_pad *pad);
>                           ~~~~~~~~~~~~~~~~~~^~~

Do you have the patches Niklas's v4l2/mux (or my vc) branch in your tree?
They change a few things on the way and drivers need to be converted.
Drivers that have been added since the patches were written do need to be
converted as well, and I suppose the sun6i_video driver is one of them.

Cc Niklas.

-- 
Kind regards,

Sakari Ailus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
