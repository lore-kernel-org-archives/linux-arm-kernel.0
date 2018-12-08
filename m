Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19168C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:25:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA3920837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZkwqjWeh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReWlemMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA3920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=anvbRTaHwkicU+hIpOAJWS1elLOQkQsAKXeh3zhvzQY=; b=ZkwqjWehaUGFVh
	RgbTXPUnplM+SveEf6spsxlIj2gwy9MF7PM62yvI88oDZGrzvxOqcT9yHxPSmTRFJTv/tUq6h3iMT
	LIj+HU/YjjU73rsObZNk+0b1z134f6ZGKk9J3EicCHYpwxUNq8qvq5GPCxIPZATQv+kRplHKAGgck
	SmQz73L0S1fog7JeqytxYl3uGlo+Nyol9Jt2RdTjh4PwI72U3bBcKvGqFtsQodfZsmcOhd+mtJ1hQ
	vgEovAho75wcC+Js7qlKaC8LWFJVqtBVATuApxrE4CMLxr3fuJx2tko5v+3C40iuvmc6kBIq86tzL
	Oaj0dy1CqT6DYr0ofSEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVTFS-0000RZ-BM; Sat, 08 Dec 2018 03:25:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVTFO-0000Qu-2M
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 03:25:44 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5BA3520837;
 Sat,  8 Dec 2018 03:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544239531;
 bh=9CL3+NIgUCLEWzVfWvxiWpfYi6dy7IyGUrgBpxtXApc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ReWlemMV7xomzTAg0x/FoGGJNCKnXDx1tctmSGxtGDZl1VkTXD9B9BEbzXo4A3IB1
 iOUXdMfd0uENGDZu7LDjZh8iVj87JQAGiC2BSj9KDXbzjHxMIqzhljJm4CYi48oiO/
 baz2UNkhjYd0mjV0PE858IKdDEzHtNl9TmeBUC+k=
Date: Sat, 8 Dec 2018 11:24:45 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v4 4/5] ARM: dts: imx5: add gpu nodes
Message-ID: <20181208032444.GP3987@dragon>
References: <20181204151702.8514-1-jonathan@marek.ca>
 <20181204151702.8514-4-jonathan@marek.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204151702.8514-4-jonathan@marek.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_192542_182610_3CB70324 
X-CRM114-Status: GOOD (  10.52  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, freedreno@lists.freedesktop.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Chris.Healy@zii.aero, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, festevam@gmail.com,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 10:17:00AM -0500, Jonathan Marek wrote:
> This adds the gpu nodes for the adreno 200 GPU on iMX51 and iMX53, now
> supported by the freedreno driver.
> 
> The compatible for the iMX51 uses a patchid of 1, which is used by drm/msm
> driver to identify the smaller 128KiB GMEM size.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
