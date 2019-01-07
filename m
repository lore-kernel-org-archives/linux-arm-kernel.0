Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E17C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:26:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AE92173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n8w08QdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AE92173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hq5u9/dnxyEeIf5K3J6PRkNqE30QTjwCtk8EXgiVszk=; b=n8w08QdIq7D3vd
	uTL4BWRCulHfM3fnV8hPFWnRH84NkcKXODzgcY8pi/gQVkYSW5CKuz/tFxYdYcgb/w0zwex6yj1FV
	5ABctGWY8+10S8ylHcKEbQRXe4t+88EZ0B+3i5ccNVwPxxOP46keOQ95FMck0Odo3BANl2xnCSC0X
	MtrmqGygylu4rdgl/2CvnuL8ECGW7l0YDaa8XRyKOgiJDhW0MkHgbIcT2oc20NmsMd19CQ3V6Djpe
	Vf8r9Pw4DXGk6RaRgqLRmGBOvsC0TQvwatIBQRisKsvNkUw3/K1/k4HWM0Vlp0vosCACjfe1kui8n
	uS4EN4UmeL9G7jx2WFGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggZbD-00006Q-RJ; Mon, 07 Jan 2019 18:26:07 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggZb8-00005j-Uu
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 18:26:05 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id E73C3FFD7D;
 Mon,  7 Jan 2019 19:25:58 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id wkQBFvO01pwA; Mon,  7 Jan 2019 19:25:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id E1B35FFD7E;
 Mon,  7 Jan 2019 19:25:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LUdJIGp02hQm; Mon,  7 Jan 2019 19:25:53 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 43495FFD7D;
 Mon,  7 Jan 2019 19:25:53 +0100 (CET)
Message-ID: <4364d7c4dc1266ca45255cdad5ba40fb20a9bea3.camel@v3.sk>
Subject: Re: [PATCH v2 13/17] power: supply: olpc_battery: Use DT to get
 battery version
From: Lubomir Rintel <lkundrak@v3.sk>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 07 Jan 2019 19:25:52 +0100
In-Reply-To: <20181205205459.bsumxn57hjjzvqaj@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-14-lkundrak@v3.sk>
 <20181205205459.bsumxn57hjjzvqaj@earth.universe>
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_102603_312522_D6F3A63B 
X-CRM114-Status: GOOD (  20.02  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>,
 James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org,
 Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2018-12-05 at 21:54 +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Nov 16, 2018 at 05:23:59PM +0100, Lubomir Rintel wrote:
> > Avoid using the x86 OLPC platform specific call to get the board
> > version. It won't work on FDT-based ARM MMP2 platform.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> I assume this patch cannot be applied to power-supply without patch
> 12 having been merged to avoid breaking XO1.5 devices temporarily?

That is true. What's the correct way to deal with a situation like
this? Just hold the patch until the other changes get in, perhaps via
linux-platform-drivers-x86.git? Or maybe this can go in together via
that tree along with the other patches?

Thanks
Lubo

> -- Sebastian
> 
> > Changes since v1:
> > - Sort the new include a bit higher
> > 
> >  drivers/power/supply/olpc_battery.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/power/supply/olpc_battery.c
> > b/drivers/power/supply/olpc_battery.c
> > index 5a97e42a3547..5323987d9284 100644
> > --- a/drivers/power/supply/olpc_battery.c
> > +++ b/drivers/power/supply/olpc_battery.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/types.h>
> >  #include <linux/err.h>
> >  #include <linux/device.h>
> > +#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/jiffies.h>
> > @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct
> > platform_device *pdev)
> >  	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc,
> > NULL);
> >  	if (IS_ERR(olpc_ac))
> >  		return PTR_ERR(olpc_ac);
> > -
> > -	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> > +	if (of_property_match_string(pdev->dev.of_node, "compatible",
> > +					"olpc,xo1.5-battery") >= 0) {
> > +		/* XO-1.5 */
> >  		olpc_bat_desc.properties = olpc_xo15_bat_props;
> >  		olpc_bat_desc.num_properties =
> > ARRAY_SIZE(olpc_xo15_bat_props);
> > -	} else { /* XO-1 */
> > +	} else {
> > +		/* XO-1 */
> >  		olpc_bat_desc.properties = olpc_xo1_bat_props;
> >  		olpc_bat_desc.num_properties =
> > ARRAY_SIZE(olpc_xo1_bat_props);
> >  	}
> > @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct
> > platform_device *pdev)
> >  
> >  static const struct of_device_id olpc_battery_ids[] = {
> >  	{ .compatible = "olpc,xo1-battery" },
> > +	{ .compatible = "olpc,xo1.5-battery" },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, olpc_battery_ids);
> > -- 
> > 2.19.1
> > 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
