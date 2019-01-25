Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ABCC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:43:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0BC218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LBR2frFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0BC218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sDOY41Ud1A12SShXG2XZHr9/cKqYwmpf3Ylty9k2tRI=; b=LBR2frFztkDprf
	ar/laZuiuV3dK3ANsukIurd01/zgHzIphNpEjP+MT5pkwMJw04x30kRH5zBXhpxHpRxYpxF3y/S7N
	X05ALCyVIwgvtha3KFCC/GQrt6dTV3jM/5X1eFVdLh0bNmMyj4H1txDAqbhyzW2v04zMdQOcO5WnT
	tNNC1BaQxCUsWGu7CyM1czfXL5VvAVvClk8xiF8JtM4U7jff4HiSNUbsxxN4OfDMKRVlBK348tGoZ
	H/rL7/HTCX6TQf/qs+CbToH9q9rrKcA2VNYqVvnd6n5eULSKMsfurqgK3ddCYOrA2WcxDjXD3EP5d
	FY8XY8IWgI2EXZrMTwBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyxm-0000PH-Jj; Fri, 25 Jan 2019 10:43:54 +0000
Received: from asavdk3.altibox.net ([109.247.116.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmywd-0006Mx-F8; Fri, 25 Jan 2019 10:43:15 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk3.altibox.net (Postfix) with ESMTPS id A78E720057;
 Fri, 25 Jan 2019 11:40:33 +0100 (CET)
Date: Fri, 25 Jan 2019 11:40:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 01/26] drm/irq: Don't check for DRIVER_HAVE_IRQ in
 drm_irq_(un)install
Message-ID: <20190125104032.GA27214@ravnborg.org>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
 <20190124165831.16427-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190124165831.16427-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=JfrnYn6hAAAA:8 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=7gkXJVJtAAAA:8 a=-wFMkYpdgSpu5CXY80EA:9
 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
 a=E9Po1WZjFZOl8hwRPBS3:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_024244_653687_D4089F59 
X-CRM114-Status: GOOD (  10.24  )
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
Cc: linux-arm-msm@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-renesas-soc@vger.kernel.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 linux-amlogic@lists.infradead.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel.

On Thu, Jan 24, 2019 at 05:58:06PM +0100, Daniel Vetter wrote:
> If a non-legacy driver calls these it's valid to assume there is
> interrupt support. The flag is really only needed for legacy drivers.
> 
> Also remove all the flag usage from non-legacy drivers.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org

The actual code changes looks good.
But if this is the right thing to do I cannot tell.

On this (limited) basis I provide an:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
