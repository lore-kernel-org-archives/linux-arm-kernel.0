Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8DAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:12:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F52217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FU45pxS9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="un81j+8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F52217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2G7j9bBYMfsVvqhcecMlf5nWE8pd84ByClDlGjh3paw=; b=FU45pxS9QQB+Eu
	pbQJ0x9LVj7w3d679LCQlVUD2v4jOLAPBJUz1hkH0DM4QfJF4mtVwP3B4p1VPOZlIfs7HSzDRIg71
	0td5oJymwSFvKxfgte0s9EaNQ9/IIt28aN8DyNZ7LeuAYpY5Fr32sdYYw8zKMXNjg1ABiDj1qdnm2
	afLreaafMhzckGMWfgyqJFX5a7AArHLp8jgMZSCDmlRPGcWlIK0wLWV8JkW+pk8zJs4gED9KkNCBO
	w47TTpnjiAdzYVBcm4YnGKuJJXWunPiJNgBNxz8rPW4JYQsJ9mMptLoU7ecuu6xlG0bUNbKoBiYHf
	SLA7bj6pJ0xH17Fy3d5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyWuz-0002CY-2u; Tue, 26 Feb 2019 07:12:45 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyWuv-0002By-0O
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 07:12:43 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190226071237euoutp01287ef028dac98c59a06d4ea7743ecff6~G2H4cRxkT2002520025euoutp01Y
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 07:12:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190226071237euoutp01287ef028dac98c59a06d4ea7743ecff6~G2H4cRxkT2002520025euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1551165157;
 bh=SAu7VJe1aXwnuMdOxwPiVQ8Dlt2emoJsCuoglsL++tY=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=un81j+8B32u74bEnUNc4Phvc7FCX1p5tdFp1bH7wqB6Rorg18RQ4ZHSU+ISpswgkK
 ny/EcVMdhbPM4YCfjEzjEZhINzxCJiGmk87P2N94rXDlfLeld6usojB70f67e3pyi0
 ox4mCpz1MIUQeBTbC8hgQ17D9J56OjLpMSV2YEyk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190226071236eucas1p16092bfd7f541cf6dba3a21974f80002d~G2H3VFMCt1688616886eucas1p1K;
 Tue, 26 Feb 2019 07:12:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 65.64.04294.4E6E47C5; Tue, 26
 Feb 2019 07:12:36 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190226071235eucas1p209889ba789253f901c1c7ef1f42a7f17~G2H2Vw7oP0757107571eucas1p24;
 Tue, 26 Feb 2019 07:12:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190226071235eusmtrp2479ef274cb28095b4c54ccaab7b5358a~G2H2Gltvq1587615876eusmtrp27;
 Tue, 26 Feb 2019 07:12:35 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-9a-5c74e6e4a1fe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id F8.BC.04284.3E6E47C5; Tue, 26
 Feb 2019 07:12:35 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190226071234eusmtip25b9a4c429502753021ec48a0e114af6b~G2H1auUfl2989829898eusmtip2O;
 Tue, 26 Feb 2019 07:12:34 +0000 (GMT)
Subject: Re: [PATCH v3 05/11] drm/bridge: Add Analogix anx6345 support
To: Vasily Khoruzhick <anarsoul@gmail.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <8f0e5932-7dba-e7a8-9adc-d15e67ffde46@samsung.com>
Date: Tue, 26 Feb 2019 08:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+E=qVe1UOxprkG+zm1OX87f9vOPyHom=hxhnzGxidBA54WxkA@mail.gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH+z7Pc8891xzfTrnP0pibNjLCjO+WNWL2GBv+a7mNo0eiX7vn
 QpoVye4QZZSu9IP8GG0SrsSNnZRDJRJaqVVqzIOtK7VSuudh+u/1/bzfnx/v7cvROisbyMUm
 WARzginOwPoyjrqRpsW9fRbj0lxbAMlqdFMks64PkWNWSUUmHDk0Ka5tVJGWwR8sGSj9RBFb
 TpmaVPa0qshod52aXH3fTJGuL48RyXTWqklHRQMiIzVFDBlxNVFrMH9lZJziy4vKEV9UnsoX
 pDcz/NszWRRf0X1LxTuHShj+gb1DzT/KcbN8gTVfxVfetLF81VCXiu88VU/xd8vS+IHKOVtn
 RPmujhbiYg8I5tDwnb57bWeG2aTRBYccp1vodFQx5yTScIBXQHHTUeok8uV0+AaCt+fPs15B
 hz0IMlpCFGEAQabkVv3r+OCuRYpwHUFfSRejPCQEDa5TjNc1E2+A8WuXZPbHIfDsyRjrNdG4
 n4HfL6rkUSxeCL/vfpT3aXE41D6UZGZwMBReaJM5AEfC06zvSPH4gTu/Vx6qwdvg58RP2UPj
 uVAlFdIK66Gtt1gOBLiagzcFTla5ez1kN774yzPha/09tcJBMPHA2+DlNDiW30IrzVYEz69c
 /9sQBk/rmyev5iY3LITbNaFKeS24OzxyGfB0+CD5KTdMh3OOPFopa8F6Qqe450Fnw31aYT1c
 fT3IZiODfUoy+5Q09ilp7P/3liDmJtILyWJ8jCAuTxAOLhFN8WJyQsyS3YnxlWjyf74cr/dU
 o5qxXS6EOWSYpn3eKRp1KtMBMSXehYCjDf7aMJfFqNNGm1IOC+bEHebkOEF0odkcY9BrU326
 tutwjMki7BeEJMH8T6U4TWA6QkceFW9oz3bMv5ezyn7xVe+ad+s3/sqLWlYhlV12Re7WxkZE
 RAc5/XNJp/54hN9w9ViYpnXzkFB6NnjLtIHBUGmfSEIv9Gsa7kSNz+pZvi5An3HjfbvWXtK6
 0xPkXDk4z7jIbCTBWd+sUtuelRM7Pq9weqJsll2rfNpnr92UUWo2MOJe07IQ2iya/gC8YtcJ
 mwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH932e55476ng6zHe2sFsoq+PxI1/FyT/2aKtV2ipp3HiG5e50
 z51FW0nTODHX1h+ODkN/YE3o/ErpErOGOZJsZEiTCVNidxF3tfnvtc9erz8+21uAi8p5HoJ0
 hZpVKWQZYtKR+LDdP31ibkGdEFi+JETFQwMYyu9bACivYJmHdow6HFX2DvHQ2K8VEq1XT2Oo
 UFfLR81z4zxkme3jo7pPIxiaWXwDUH53Lx9NNQ0CtNVpINCWaRg7QzE1W9sY02hoBIyh8Q5T
 njtCMKMlxRjTNNvAY7o3qgimQz/FZ17pBkimvKCMxzTXF5JM28YMj/lS1I8xLbX3mPVmzwvO
 8ZIIlVKjZr3TlJw6UnydRkESOhxJgkLCJXRw2I1TQaHiAGlECpuRnsWqAqRJkrTCkk0y03L0
 tvHRGJ4Lmjy1wEEAqRA4MdAL9lhE1QHY8Vhgv7vDrspl3M4u0DquJbXAcddZAlBn/mELXKgY
 uP3sKbHHrpQ/fN9jtUk4tUjAaqsVsxcvMTj78bfNIqlj8E/LZ3KPhZQU9nYt25igfGDFk0kb
 u1FX4drX15jdOQQHyuZtrQN1Ea7urNocnPKDVoMZt7MXbFuu+MfucHK+EisFIv2+XL8v0e9L
 9PuSKkDUA1dWw8lT5Rwt4WRyTqNIlSQr5c1gdxjGvq2WdmB+EWcClACIDwq9Z7kEEU+WxWXL
 TQAKcLGr8LRJnSASpsiyc1iVMlGlyWA5EwjdfU6He7glK3dnplAn0qF0GAqnw4LDgk8isbtw
 ODA7XkSlytTsTZbNZFX/O0zg4JEL5LID2rOeCe2W+bhky+hInAZPLJrxdbp/hMy9NsXfcS5Y
 yFhbvFW6gvVXxuZFN1rNPc+/q6XfLsV0eeUcl7geHgxv8Il5GLvteffdaHSUcf1ckqBz0/98
 yeU+p9bumqQHQVm0s5ulY8zPoyZqQtFanWOMlGp3hq4Yfvq/HYaFvmKCS5PR/riKk/0FbItU
 LC4DAAA=
X-CMS-MailID: 20190226071235eucas1p209889ba789253f901c1c7ef1f42a7f17
X-Msg-Generator: CA
X-RootMTR: 20190215051043epcas5p37cd953f0a76fb34e819b45c330dc6368
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215051043epcas5p37cd953f0a76fb34e819b45c330dc6368
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <CGME20190215051043epcas5p37cd953f0a76fb34e819b45c330dc6368@epcas5p3.samsung.com>
 <20190215050957.20755-6-anarsoul@gmail.com>
 <7d71654e-7169-2682-5655-0a9a9ea91c6d@samsung.com>
 <CA+E=qVe1UOxprkG+zm1OX87f9vOPyHom=hxhnzGxidBA54WxkA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_231241_348598_F4C55640 
X-CRM114-Status: GOOD (  31.03  )
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

On 15.02.2019 20:36, Vasily Khoruzhick wrote:
> On Fri, Feb 15, 2019 at 1:13 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> Hi Andrzej,
>
> Thanks for review!
>
>>> +#include <linux/of_gpio.h>
>> Do you need this header?
> I'll drop it.
>
>>> +#include <drm/drmP.h>
>> drmP.h is/should be deprecated.
> Same here
>
>>> +struct anx6345_platform_data {
>>> +     struct regulator *dvdd12;
>>> +     struct regulator *dvdd25;
>>> +     struct gpio_desc *gpiod_reset;
>>> +};
>> Why do you need this struct, why just do not embed it's fields directly
>> into struct anx6345 ?
> OK, I'll embed it into struct anx6345
>
>>> +     if (WARN_ON(anx6345->powered))
>>> +             return;
>> It should not happen, you can remove this warn.
> OK
>
>>> +     if (pdata->dvdd12) {
>> If regulators are required this will be never null.
> Right, and regulator subsystem will return dummy regulator if it's
> missing in dts.
> I'll remove redundant checks.
>
>>> +
>>> +     if (pdata->dvdd25) {
>> ditto
> OK
>
>>> +
>>> +     if (anx6345->panel)
>>> +             drm_panel_prepare(anx6345->panel);
>> again, here and below: panel is never null, check can be removed.
> That's not true, panel is optional. It can be DP connector, not a panel.
>
>>> +
>>> +     gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
>>> +     usleep_range(1000, 2000);
>>> +
>>> +     gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
>>
>> Start/stop sequence seems odd regarding reset gpio:
>>
>> 1. In probe reset is set to low, in poweroff to high - incosistent.
>>
>> 2. If in case of disabled device reset should be 0, there is no point to
>> set it again to 0 three lines above.
>>
>> 3. I suspect in dts reset gpio should be declared as active_low, and the
>> logic in the driver should be reverted, in power off it should be set to
>> high, in power on it should be lowered (logically).
> OK, I'll look into it.
>
>>> +err_poweroff:
>>> +     DRM_ERROR("Failed DisplayPort transmitter initialization: %d\n", err);
>> redundant message
> OK, will drop.
>
>>> +             DRM_ERROR("Get sink count failed %d\n", err);
>> The rule of thumb I heard is that if you start message capitalized you
>> should end with dot. Since I do not know if it is enforced in kernel I
>> leave the decision up to you.
> I grepped DRM_ERROR in driver/gpu/drm and they do exactly the same as here.
> So I'll just keep it as is for consistency.
>
>>> +static bool anx6345_bridge_mode_fixup(struct drm_bridge *bridge,
>>> +                                   const struct drm_display_mode *mode,
>>> +                                   struct drm_display_mode *adjusted_mode)
>>> +{
>>> +     if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>>> +             return false;
>>> +
>>> +     /* Max 1200p at 5.4 Ghz, one lane */
>>> +     if (mode->clock > 154000)
>>> +             return false;
>> These checks should be in mode_valid callback.
> OK
>
>>> +     /* Map slave addresses of ANX6345 */
>>> +     for (i = 0; i < I2C_NUM_ADDRESSES; i++) {
>>> +             if (anx6345_i2c_addresses[i] >> 1 != client->addr)
>>> +                     anx6345->i2c_clients[i] = i2c_new_dummy(client->adapter,
>>> +                                             anx6345_i2c_addresses[i] >> 1);
>>> +             else
>>> +                     anx6345->i2c_clients[i] = client;
>>
>> I see this contredanse is copy/pasted from anx78*, but it looks quite
>> complicated. As I understand there are two i2c addresses, why we cannot
>> assume one address is for control interfaces and another  is dummy? It would
>> simplify the code here and in other places.
> Sorry, I don't get you, could you elaborate? Note that anx6345 uses
> both addresses,
> i2c_new_dummy() just registers new i2c device bound to a dummy driver and it's
> supposed to be used for devices that consume more than one i2c address.


My idea was to assume that ANALOGIX_I2C_DPTX is the main address, ie.
address which should be set in dts in device node reg property.

Other addresses should be registered as dummy devices during probe -
simple loop without conditionals, without redundant fields in anx6345
context - i2c_clients, client.

I do not insist on this change but I suggest as it should simplify the code.

And moreover, you can consider removing direction bit from i2c
addresses, it could be also confusing and against i2c kernel api.

>
>>> +     if (!found) {
>>> +             DRM_ERROR("ANX%x (ver. %d) not supported by this driver\n",
>>> +                       anx6345->chipid, version);
>>> +             err = -ENODEV;
>>> +             goto err_poweroff;
>>> +     }
>>
>> As I see chip becomes powered forever, is it OK? Usually it should be
>> powered only when pipeline starts, and powered-off after pipeline stops.
> I'll look into how hard it would be to implement but personally I
> think it's OK for now.
> We can add more sophisticated power management once this driver is merged.


But the rule is every resource allocated/set during lifetime of the
driver should be dropped on driver removal, so please do it at least in
remove callback.


Regards

Andrzej





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
