Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B77C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:36:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20E7222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EedxIo6r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ3srTNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20E7222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dPxUCdRYc53wSUcENsI0qCso70deBq/Gd2QKAgNND8c=; b=EedxIo6rycbAgf
	hfi6LEaXPgS+n4GuzsFmtbmbAC4fd+LWeWdHtJnKfRzIqNz62+j8rsIPKCiKGrdiNHbw/5wIuzmdQ
	RHaCAqYR8biONVcpbsVHM0A1dZyQT6dimgNEgh05wkYPpiEONvjJ+5cTogAnM0kxAtFqjq0+FEzaU
	NLnhODwQrUBSh2FpN4TWo50VYr4NOdk9NWeukGUBAA+6sdLsGyHgzu1fV3583IMCSjMjZOpMNSxcH
	oGc6kZR6kAD2fB81HFovKU5BjegGduQXTl4DdiHuZD0YBPZIIXwuieQVhJgEhmXLB4TUJyl4Sehm1
	ten3bds9SApQl1dK5vYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujHs-0007vr-I6; Fri, 15 Feb 2019 19:36:40 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujHp-0007vX-EE
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:36:39 +0000
Received: by mail-ot1-x344.google.com with SMTP id g1so18387096otj.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=46q43Jx11uswLeLjDPuJ9o+ihz8Lrcqkcczy/VoH+u4=;
 b=aJ3srTNNc9RTdpQQlxElpYfjgXOcRidiQHGNpNKIWJJ3yirW31LpBrgPLYyj2EPc5V
 criPUdC4ThHouDGAQXiQEXBO67P3IGVIp0Y8LbqRo0eKMgYzEXfY4xI434c+/KGK8V0x
 O8GQdwPiF8aiRjqBueRlyohhcYKaWvFB/fRc3trEKMQX3KnAXSWOLZp6ou1cLpWBcusa
 VltoUjBDeemxdscJJ3E2i/8BsaseaoEq4gwOv1S9RnCJHqDGZcOdiRLqU5C7x6LZp8AC
 Qsn3Ad6BZfCxPoAn/q11BhSJyuR4sFyfT662uIboV06mxPrzrLJ5Mgu7tsVsvU06ihbQ
 M9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=46q43Jx11uswLeLjDPuJ9o+ihz8Lrcqkcczy/VoH+u4=;
 b=bnipWJFpptohC61R64FzvwaTP1BOI4x/NrLqRooqO6TS53YfLnWTJs6K3hbfBMiAQh
 m8tgk9s5MIw9ieM88RksJ/9rIyFUs99kjc0l4HWT83SFRBTyeuEGWWQJi2WDXv9vgG6p
 Qchs26JgevLZr8R/1wLlHD7lTCyNMea/ZjnANWLXwlh+VB/3KIf6AQkObC2dMlcdkIWo
 xOnzGOEwp8FHUXo+rN9CYbMJMbMrOOTbbQpxpeybM3cS6A3B5ccJBBSHeQ8PyBWT1GCZ
 DZohTd/h2Nid96TGWBWjpeX6ReOtk2xFWIuSlj1e2aNu4uemFdmTgykyydqx32/MnV58
 tPhw==
X-Gm-Message-State: AHQUAuaCXCPqxoIBUwakiHbkEpEQm8sUS+kqt48wZIdmRkWmx9MLFYHr
 05TjMnchtTdZtqW06KaXWvGwm2Pz4Yh0fvHahhs=
X-Google-Smtp-Source: AHgI3IatitUDZlUrwDmkZItZrHssHpPK438YCGYYnCFc04sym0HpRc6Mid/M+TGCci+R/yZxZ/YsUilhsDAoVMZuL+8=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr6331974otn.111.1550259396598; 
 Fri, 15 Feb 2019 11:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <CGME20190215051043epcas5p37cd953f0a76fb34e819b45c330dc6368@epcas5p3.samsung.com>
 <20190215050957.20755-6-anarsoul@gmail.com>
 <7d71654e-7169-2682-5655-0a9a9ea91c6d@samsung.com>
In-Reply-To: <7d71654e-7169-2682-5655-0a9a9ea91c6d@samsung.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 15 Feb 2019 11:36:57 -0800
Message-ID: <CA+E=qVe1UOxprkG+zm1OX87f9vOPyHom=hxhnzGxidBA54WxkA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] drm/bridge: Add Analogix anx6345 support
To: Andrzej Hajda <a.hajda@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_113637_505234_BDBACFB5 
X-CRM114-Status: GOOD (  27.56  )
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
 Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 1:13 AM Andrzej Hajda <a.hajda@samsung.com> wrote:

Hi Andrzej,

Thanks for review!

> > +#include <linux/of_gpio.h>
> Do you need this header?

I'll drop it.

> > +#include <drm/drmP.h>
>
> drmP.h is/should be deprecated.

Same here

> > +struct anx6345_platform_data {
> > +     struct regulator *dvdd12;
> > +     struct regulator *dvdd25;
> > +     struct gpio_desc *gpiod_reset;
> > +};
>
> Why do you need this struct, why just do not embed it's fields directly
> into struct anx6345 ?

OK, I'll embed it into struct anx6345

> > +     if (WARN_ON(anx6345->powered))
> > +             return;
>
> It should not happen, you can remove this warn.

OK

> > +     if (pdata->dvdd12) {
>
> If regulators are required this will be never null.

Right, and regulator subsystem will return dummy regulator if it's
missing in dts.
I'll remove redundant checks.

> > +
> > +     if (pdata->dvdd25) {
>
> ditto

OK

> > +
> > +     if (anx6345->panel)
> > +             drm_panel_prepare(anx6345->panel);
>
> again, here and below: panel is never null, check can be removed.

That's not true, panel is optional. It can be DP connector, not a panel.

> > +
> > +     gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
> > +     usleep_range(1000, 2000);
> > +
> > +     gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
>
>
> Start/stop sequence seems odd regarding reset gpio:
>
> 1. In probe reset is set to low, in poweroff to high - incosistent.
>
> 2. If in case of disabled device reset should be 0, there is no point to
> set it again to 0 three lines above.
>
> 3. I suspect in dts reset gpio should be declared as active_low, and the
> logic in the driver should be reverted, in power off it should be set to
> high, in power on it should be lowered (logically).

OK, I'll look into it.

> > +err_poweroff:
> > +     DRM_ERROR("Failed DisplayPort transmitter initialization: %d\n", err);
>
> redundant message

OK, will drop.

> > +             DRM_ERROR("Get sink count failed %d\n", err);
>
> The rule of thumb I heard is that if you start message capitalized you
> should end with dot. Since I do not know if it is enforced in kernel I
> leave the decision up to you.

I grepped DRM_ERROR in driver/gpu/drm and they do exactly the same as here.
So I'll just keep it as is for consistency.

> > +static bool anx6345_bridge_mode_fixup(struct drm_bridge *bridge,
> > +                                   const struct drm_display_mode *mode,
> > +                                   struct drm_display_mode *adjusted_mode)
> > +{
> > +     if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> > +             return false;
> > +
> > +     /* Max 1200p at 5.4 Ghz, one lane */
> > +     if (mode->clock > 154000)
> > +             return false;
>
> These checks should be in mode_valid callback.

OK

> > +     /* Map slave addresses of ANX6345 */
> > +     for (i = 0; i < I2C_NUM_ADDRESSES; i++) {
> > +             if (anx6345_i2c_addresses[i] >> 1 != client->addr)
> > +                     anx6345->i2c_clients[i] = i2c_new_dummy(client->adapter,
> > +                                             anx6345_i2c_addresses[i] >> 1);
> > +             else
> > +                     anx6345->i2c_clients[i] = client;
>
>
> I see this contredanse is copy/pasted from anx78*, but it looks quite
> complicated. As I understand there are two i2c addresses, why we cannot
> assume one address is for control interfaces and another  is dummy? It would
> simplify the code here and in other places.

Sorry, I don't get you, could you elaborate? Note that anx6345 uses
both addresses,
i2c_new_dummy() just registers new i2c device bound to a dummy driver and it's
supposed to be used for devices that consume more than one i2c address.

> > +     if (!found) {
> > +             DRM_ERROR("ANX%x (ver. %d) not supported by this driver\n",
> > +                       anx6345->chipid, version);
> > +             err = -ENODEV;
> > +             goto err_poweroff;
> > +     }
>
>
> As I see chip becomes powered forever, is it OK? Usually it should be
> powered only when pipeline starts, and powered-off after pipeline stops.

I'll look into how hard it would be to implement but personally I
think it's OK for now.
We can add more sophisticated power management once this driver is merged.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
