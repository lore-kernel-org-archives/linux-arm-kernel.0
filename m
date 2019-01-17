Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2909C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:45:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7186F20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Thv72cD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7186F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NJh5u59BeluftaCvIaNVFLKfdSIzPLUzWzQGJvksgwg=; b=Thv72cD74PRRxE
	a1G012mR3SRGyGwSWvD6GVmqMzjw9J9JvGQjujPMbU/j0Qjko29Y5lrBKddj8lS91NA+Zc0BM8imX
	avWxtMnl97f+CyUSTxLMcsSstRQ+KX/ENNelpGSqDlc7k3cY0FWaMf0/RKi4RuyuDyhC1ZOquOexH
	d2IWIGrhkIFHsoIDBOfOvfUxtLTNgNeFlJIMENUWn00I2UnswTwr9VOFXkn9CDBxbuOufwLNDWjN0
	5acq/jKKgU35tIEQiT1krEiLRHr//B7o/sz040JpXd2xas5UWZ7O6Eee8JVyWhfDKVyw55CWsToIT
	4LVpXnVJeamEjRhWzrsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkBja-0006le-C1; Thu, 17 Jan 2019 17:45:42 +0000
Received: from asavdk4.altibox.net ([109.247.116.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkBjV-0006kd-A0; Thu, 17 Jan 2019 17:45:39 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id C974F8036E;
 Thu, 17 Jan 2019 18:45:32 +0100 (CET)
Date: Thu, 17 Jan 2019 18:45:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Message-ID: <20190117174531.GA14041@ravnborg.org>
References: <20190116163442.12622-1-daniel.vetter@ffwll.ch>
 <20190116181018.GA27364@ravnborg.org>
 <20190117164541.GE3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190117164541.GE3271@phenom.ffwll.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=xwHcfvD0iotqNkNuR-sA:9 a=CjuIK1q_8ugA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_094537_700247_5ACEF66E 
X-CRM114-Status: GOOD (  22.11  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Liviu Dudau <liviu.dudau@arm.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org,
 Jani Nikula <jani.nikula@intel.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xen.org,
 linux-renesas-soc@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 05:45:41PM +0100, Daniel Vetter wrote:
> On Wed, Jan 16, 2019 at 07:10:18PM +0100, Sam Ravnborg wrote:
> > Hi Daniel.
> > 
> > > v5: Actually try to sort them, and while at it, sort all the ones I
> > > touch.
> > 
> > Applied this variant on top of drm-misc and did a build test.
> > Looked good for ia64, x86 and alpha.
> > 
> > Took a closer look at the changes to atmel_hlcd - and they looked OK.
> > 
> > But I noticed that atmel_hlcdc uses only drm_kms_helper_poll_init() and
> > drm_kms_helper_poll_fini().
> > But there are no hits on DRM_CONNECTOR_POLL - so I think we maybe
> > have a driver here where we have plugged the drm_poll infrastructure,
> > but it is not in use.
> > 
> > >  include/drm/drm_crtc_helper.h                 | 16 -----------
> > 
> > The list of include files in this file could be dropped and replaced by:
> > struct drm_connector;
> > struct drm_device;
> > struct drm_display_mode;
> > struct drm_encoder;
> > struct drm_framebuffer;
> > struct drm_mode_set;
> > struct drm_modeset_acquire_ctx;
> > 
> > I tried to do so on top of your patch.
> > But there were too many build errros and I somehow lost the motivation.
> 
> Yeah the drm_crtc_helper.h header is a bit the miniature drmP.h for legacy
> kms drivers. Just removing it from all the atomic drivers caused lots of
> fallout, I expect even more if you entirely remove the includes it has.
> Maybe a todo, care to pls create that patch since it's your idea?

The main reason I bailed out initially was that this would create
small changes to several otherwise seldomly touched files.
And then we would later come and remove drmP.h - so lots of
small but incremental changes to the same otherwise seldomly
edited files.
And the job was only partially done.

I will try to experiment with an approach where I clean up the
include/drm/*.h files a little (like suggested above, +delete drmP.h
and maybe a bit more).

Then to try on a driver by driver basis to make it build with a
cleaned set of include files.
I hope that the cleaned up driver can still build without the
cleaned header files so the changes can be submitted piecemal.

Will do so with an eye on the lesser maintained drivers to try it
out to avoid creating too much chrunch for others.

And if it works out I expect the active drivers to follow the
example.

todo.rst item will wait until I run out of energy.

	Sam


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
