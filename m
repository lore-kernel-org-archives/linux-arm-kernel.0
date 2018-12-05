Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A343C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:42:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A112084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="byvmC21H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mR12I0Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A112084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WpiSkZf7oq2QGZ1N1YTRYMakTFDsFacaoeLZqqpBk0M=; b=byvmC21HaN6Wps
	EpYe/5/JzV0u1FGQFv14P/j+fXxIqGGX+KOqBUIYZJqk5PGstjVwNhifaDoga0R3Sim1Yn6DhFE3M
	JHcBzCenOAkh7d4rgTHNcjJiJI2UkgGxbHNW7VcKoLSk0tvYpsMAZI0pOHc1g2kZsbeP71+YGwh+a
	iJmptiDfj+TZl2DNh995cM8Dy+eBlmaeuYZbfHETDxA212K4prixd0GjbYAiGay3AOxnF/g2lWc6b
	/Oh1oitVFBLrIEd9J2mAR7Tc9q2dxNX5oL4ejhJkydm/9GzD2kCt/naUA3SXp1ehEqoX9gP+KQ9kN
	B1W3ai5o6ujW5XXJvYlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbBy-0004aj-MI; Wed, 05 Dec 2018 17:42:34 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbBp-0004Yl-BF
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:42:30 +0000
Received: by mail-pg1-x541.google.com with SMTP id z10so9334382pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=H82VOLH32FQsGyx2BnmP11meBb7aRxjVMwmR5I4yftQ=;
 b=mR12I0WgDkJJk9doQzmB5CI33SvEW0wmcF1ZxUAeOImCl+7uM65cv5mpJasfv4Kw78
 5PzNV0naYFDJSQQiAUenHvkYN3vmjqhtZ1vdAqr0Xi87AwSbU0JKtcxWW+Jtr6aBluxK
 WrzJZAUa/m7NkA609kvLKDQ038DKX+sZyE53k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=H82VOLH32FQsGyx2BnmP11meBb7aRxjVMwmR5I4yftQ=;
 b=mKuOfLoMOp+BmGiV6nx3WzZS0tlExyHUCCnfhv4IWYD4Qex4HLLTfKNeql/SpOFwzo
 6zYmApkpm0qJzFBu7f3yN+rBYu5iL/0go2/RuY/RDntA2pYtE571jbe/unK/TnNUzz0W
 RHyZRgB8KQr8ElhId1M94H/xZImZu+yVnY9msJq57t3RHj8cixQE/+TYWgitDuqTx0A9
 VJKoBZ5QcXmPTrWtmySf4ykPXwvCcjddU7ss6e1C6fmhWEDsl7g0WaTxbBdEIbtcu24c
 kNxrY/rev7/OCoBocqZ8lL9V3znlKLZmOdsIfR9p24PeMe+pdEQhESSvukTQ/V1iIKmU
 TuOQ==
X-Gm-Message-State: AA+aEWZY7zPTcTUXh53i0NYi6p7yC0YrZ2J1WNq92hNk98Cxu4UJjJqI
 u17Xr/YEeXeTH0HMuScbtY3YwQ==
X-Google-Smtp-Source: AFSGD/Vya30S7Xoif9HN5bgrX0P/yaC6sJypQyj6h1u0MMLshTlK1kv74VJG/+5PyCQq7ftlVWWx2Q==
X-Received: by 2002:a62:3241:: with SMTP id y62mr25246550pfy.178.1544031734383; 
 Wed, 05 Dec 2018 09:42:14 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id g11sm26168194pfo.139.2018.12.05.09.42.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 09:42:13 -0800 (PST)
Date: Wed, 5 Dec 2018 09:42:11 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] drm/rockchip: Allow driver to be shutdown on reboot/kexec
Message-ID: <20181205174209.GA224281@google.com>
References: <20180805124807.18169-1-marc.zyngier@arm.com>
 <20181205030127.GA200921@google.com> <1693737.bVF0dcvACY@diego>
 <dd1777ad-fe3e-a661-a27f-8ba418064b40@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dd1777ad-fe3e-a661-a27f-8ba418064b40@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_094226_459506_993D9ABC 
X-CRM114-Status: GOOD (  29.73  )
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
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Dec 05, 2018 at 02:28:48PM +0000, Marc Zyngier wrote:
> On 05/12/2018 14:11, Heiko St=FCbner wrote:
> > Am Mittwoch, 5. Dezember 2018, 04:01:34 CET schrieb Brian Norris:
> >> On Sun, Aug 05, 2018 at 01:48:07PM +0100, Marc Zyngier wrote:
> >>> Leaving the DRM driver enabled on reboot or kexec has the annoying
> >>> effect of leaving the display generating transactions whilst the
> >>> IOMMU has been shut down.
> >>>
> >>> In turn, the IOMMU driver (which shares its interrupt line with
> >>> the VOP) starts warning either on shutdown or when entering the
> >>> secondary kernel in the kexec case (nothing is expected on that
> >>> front).
> >>>
> >>> A cheap way of ensuring that things are nicely shut down is to
> >>> register a shutdown callback in the platform driver.
> >>>
> >>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >>> ---
> >>
> >> This patch made it into 4.20-rc1 as well as -stable, and it has caused
> >> regressions for me, on the Kevin and Scarlet [1] RK3399 platforms.
> >>
> >> On
> >> shutdown/reboot, I see this:
> >>
> >> [   94.742559] WARNING: CPU: 4 PID: 2035 at
> >> drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x1c4/0x=
294
> >> ...
...
> >> Anyway, the above warnings occur on v4.20-rc, which I think is
> >> justification enough for a revert.
> > =

> > That's strange. I remember testing quite a number of shutdown/reboot
> > cycles before applying that patch. And for good measure did the same
> > again right now.
> > =

> > - Kevin, with netboot firmware, booting into Debian+console only
> > - Bob, with stock firmware, booting into Debian+KDE Plasma
> > - Scarlet, with stock firmware, booting into Debian+KDE Plasma
> > =

> > With some random number of reboot and shutdowns on each I didn't
> > see any warnings at all.
> =

> And I've been using this very patch for quite a while now.
> =

> Before suggesting a revert, I'd rather we understand what is going on,
> and why is the DRM layer crapping itself that badly for a legitimate
> operation (it is certainly better to have a shutdown than to let the VOP
> scan out crap once the IOMMU has been shut down). In short, don't shoot
> the messenger.

I honestly don't know much at all about DRM. But I do see this problem
on 4.19.y also (and probably 4.14.y), now that this patch was included
there.

I'm fine with trying to "fix forward" in mainline, but unfortunately,
it's usually quite difficult to get Greg to drop things from -stable,
especially when the regression is already pushed to a release. That's
why I'd propose a revert first, which can be sent back to -stable while
things are figured out.

I'm also willing to test any updates, if you have better suggestions.

> >> I plan to submit a revert which I hope can go to 4.20 as well as
> >> -stable. I'd hope the remove()/shutdown() paths should be fixed before
> >> this gets applied again, and that it does not get shipped to -stable
> >> kernels.
> > =

> > But judging by the fact that the warning indicates that somthing is sti=
ll
> > holding onto a framebuffer and a rmmod rockchipdrm is not possible
> > at runrtime for likely the same reason, I guess we really might be crea=
ting
> > a problem with that shutdown.
> =

> That's a potential root cause.
> =

> > =

> > Can you maybe give "drm/rockchip: shutdown drm subsystem on shutdown" [=
2]
> > a try? When the underlying issue of rebooting surfaced we had 2 competi=
ng =

> > solutions, so we at least don't reopen the issue, that people have prob=
lems
> > rebooting?

I'll try to give that a spin.

> kexec working is certainly something I need. And I'd like to understand
> why Brian sees this and nobody else.

For one, I'm actually running Chrome OS. My tests currently don't have
the full Chrome UI working, since Chrome OS has some basic graphics API
requirements and there's no Mali GPU driver upstream (so I get relegated
to our splash screen and console manager, frecon, instead). But some
people have a software-rendered llvmpipe backend working, and they
likely would see the same problem.

Maybe common Linux distros treat "no GPU" too simplistically and don't
really exercise the DRM framework much. I dunno.

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
