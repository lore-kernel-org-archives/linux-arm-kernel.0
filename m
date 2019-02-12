Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82AAC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:18:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7396D2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bYLy80Ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7396D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EKtjNoGMTK1Istk/vEBDdVl93R2/nlimr5chg4iVRgo=; b=bYLy80Ww1Sai3H
	VXGany1CRrrvmak5r6g/H2d9dTL7DrNqV22hWB/D5ysSSXHBA7VeSlgx1joCYkiLydLtQ9QgtpeTj
	/noZONpBKq3w/skoEPxNMhWSdaRLr56MCkZrNgAcGql17tLzFrzfuukvwURlcNFd3nqcu4SCI4Rhp
	GmHbB8SV8Yla5COkSdTy4U/NrcENhVL6hCq1DEEIyNW/m5cgvAfjfYhLOqRn+joDP2ASdPQj57vYm
	xudK3E/CYIofOV6vIr8UEYrVmS8cx+bGLmq8wAEAX2VRGGr6nc/GFPGtka6bfGkhII3ZGLIvcN0zY
	hexlU9mg4aP1UzEOuiJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtfRS-0006sr-9F; Tue, 12 Feb 2019 21:18:10 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtfRP-0006sM-9I
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 21:18:08 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id 20B0327FB65
Message-ID: <fb7e6bf4474583535961712bac5248b43dd47af0.camel@collabora.com>
Subject: Re: [PATCH v3 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Hans Verkuil
 <hverkuil@xs4all.nl>
Date: Tue, 12 Feb 2019 18:17:52 -0300
In-Reply-To: <20190212130548.tytlxmbu4q6qgzzq@flea>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <562aefcd53a1a30d034e97f177096d70fb705f2b.1549895062.git-series.maxime.ripard@bootlin.com>
 <716ae1ff-8e62-c723-5b5a-0b018cf6af6a@xs4all.nl>
 <db7a762a-8bc3-0391-036b-1fda2e445023@xs4all.nl>
 <20190212130548.tytlxmbu4q6qgzzq@flea>
Organization: Collabora
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_131807_454117_C758C89F 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, acourbot@chromium.org,
 jonas@kwiboo.se, jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sakari.ailus@linux.intel.com, Guenter Roeck <groeck@chromium.org>,
 nicolas.dufresne@collabora.com, posciak@chromium.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-12 at 14:05 +0100, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Feb 11, 2019 at 04:21:47PM +0100, Hans Verkuil wrote:
> > > I think the API should be designed with 4k video in mind. So if some of
> > > these constants would be too small when dealing with 4k (even if the
> > > current HW doesn't support this yet), then these constants would have to
> > > be increased.
> > > 
> > > And yes, I know 8k video is starting to appear, but I think it is OK
> > > that additional control(s) would be needed to support 8k.
> > 
> > Hmm, 4k (and up) is much more likely to use HEVC. So perhaps designing this
> > for 4k is overkill.
> > 
> > Does anyone know if H.264 is used for 4k video at all? If not (or if very
> > rare), then just ignore this.
> 
> I don't know the state of it right now, but until quite recently
> youtube at least was encoding their 4k videos in both VP9 and
> H264. They might have moved to h265 since, but considering 4k doesn't
> seem unreasonable.
> 

Just asked the multimedia team here, and they say that 4k videos are in
fact widely used for both H264 and VP9 because of the HEVC licensing issues,
and because gains in compressions are not so impressive.

Regards,
Ezequiel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
