Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:13:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E66218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JsmUbTWG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn2eoqLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E66218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xvbAMFVsfFsDJBnHg5s24kAxIhFpHQn62m86TKDivj4=; b=JsmUbTWGodiIVc
	gtAOZR9TjcQxX3AbkVkZ3IepkDJUcYgBX3VePZF6DHcSC2ilfqgJ910ejKPuY4UytJBn1wLI1bR8+
	l5Gk/UrMnSUpC+84POXO0mnV4+NFNTSRBvcRU7Rqknhlf3ACk6h4ti8dHwd2C1U1UtthoNXPEUSw8
	9kjlCK8mvr2WmhApnegpRFvU+vuTVaoEtk7PCGpK0gcZDxTyikGlXt6VFywCHML1OpsTaIX1q4wjV
	HJmcZ9PQFAHSftgRyKRjQLTPpaoKlseVwntcIONcz3QjKwd4IM3qx6qXsG78JJCQMrVxOlFCfCRPF
	SOCtv/4gj4CjNNyT7eZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3AA-0006Lw-1z; Fri, 25 Jan 2019 15:12:58 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3A6-0006L4-Du; Fri, 25 Jan 2019 15:12:55 +0000
Received: by mail-vs1-xe42.google.com with SMTP id z3so5847259vsf.7;
 Fri, 25 Jan 2019 07:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qeeS4c88knSK89mk8R7AcXjNNhDwhbuq8XG6IWuEQUk=;
 b=gn2eoqLKbhkShzqIB3CeXdajIYFk17aTIdPZdkEeNNHuHTnorLv57GuUFcRyyRLpl/
 fJTwVJdNyXDk+somaX/sl7vN/EjYYZyrihbBBbSo6ZiyE0IJn8P5MMxI5pY8h9SE2VhM
 zKpG9/qf+nFTvbqr2By762JF/pDZeq+rDqW7Ry/cVEvV6AHDdcgG15vSM9tNsNxadfNE
 Pl8ISJlu5u+cVEEEz2hm74/KSsh8DO8wWOqYFB84KMOig9r6VNCDcmiLj1A8knbulC5I
 65lFE2rgoq48vrzmIoXYJaRX07PTCm+QQTPJWK2rEm9xPzL7EpaLVRysFVPbDu+doaoq
 0KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qeeS4c88knSK89mk8R7AcXjNNhDwhbuq8XG6IWuEQUk=;
 b=nFjdaOeiH2BYfQAxrkqIsZUkL3IsZ1oRvyp52/UQwzIBloZr98pS+SHHLpCHgtrMrZ
 oQBmBEaAECqoJsyIa7uSlC5O4lZzkydSMZqpjQ2pN+oNKoDjZf3FsTH8lxkRtLLMeMb0
 Wg4ji0WKakvTeLUdTTnKey0hUXX/S83x3R4EevbHfLPdrsQ5nsTIuzcT972q7WMG7OD9
 ynLg/o3KOSfrr88JMya7EyKvgXT+6nYkocjXITuMABrORGZpPSfdsKlzuoSfTYqvec++
 O0M+lO46jkFJ1MLImWnOsqvvajzA+vdHsJgvQT51oHuTvXvbBPlJRE2uj2cUHzqFaNlR
 zj7A==
X-Gm-Message-State: AJcUukeJJmfV2FTt5RaN1Rq1aqR+BVs+IYkqfcn18tC6mb+jzoH9Lkju
 SyrpImijrQ+N3irkLZKbfdeb5pO4L0AYctQy4RI=
X-Google-Smtp-Source: ALg8bN4TdPePO5U3SZKFlVwm6CHk+iHb487nVCQWm00orfsqe8O/kc6JsiOLu8DUZqBq5yIaJW7RSm7lKVV6TgnDTu0=
X-Received: by 2002:a67:cf02:: with SMTP id y2mr4613740vsl.118.1548429171526; 
 Fri, 25 Jan 2019 07:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
 <20190124165831.16427-2-daniel.vetter@ffwll.ch>
In-Reply-To: <20190124165831.16427-2-daniel.vetter@ffwll.ch>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 25 Jan 2019 15:09:00 +0000
Message-ID: <CACvgo52A2Cb3RLRZdGopcbUb6424XnVJkU2PYC0sJGFie4ueyg@mail.gmail.com>
Subject: Re: [PATCH 01/26] drm/irq: Don't check for DRIVER_HAVE_IRQ in
 drm_irq_(un)install
To: Daniel Vetter <daniel.vetter@ffwll.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_071254_495891_A33100BE 
X-CRM114-Status: UNSURE (   7.27  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 linux-renesas-soc@vger.kernel.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 linux-amlogic@lists.infradead.org, freedreno@lists.freedesktop.org,
 LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 16:58, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> If a non-legacy driver calls these it's valid to assume there is
> interrupt support. The flag is really only needed for legacy drivers.

... legacy drivers which issue the IRQ via the DRM_IOCTL_CONTROL legacy IOCTL.

At a later stage, we might as well add LEGACY to the name:
DRIVER_LEGACY_HAVE_IRQ?


>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      | 2 +-
>  drivers/gpu/drm/arm/hdlcd_drv.c              | 2 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 2 +-
>  drivers/gpu/drm/drm_irq.c                    | 6 ------
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c    | 2 +-
>  drivers/gpu/drm/gma500/psb_drv.c             | 2 +-
>  drivers/gpu/drm/i915/i915_drv.c              | 2 +-
>  drivers/gpu/drm/meson/meson_drv.c            | 2 +-
>  drivers/gpu/drm/msm/msm_drv.c                | 3 +--
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c            | 3 +--
>  drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
>  drivers/gpu/drm/radeon/radeon_drv.c          | 2 +-
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c     | 2 +-
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c          | 2 +-
>  drivers/gpu/drm/vc4/vc4_drv.c                | 1 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          | 2 +-
>  drivers/staging/vboxvideo/vbox_drv.c         | 2 +-

Local grep shows one more non-legacy entry in
drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c

With that file addressed and trivial comment additions, patches: 1, 2,
3 and 26 are
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

HTH
Emil

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
