Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:02:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095F92085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q89AIVns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095F92085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8xJVcxlDyyEFuSDUQaBncnotcE9c4NJ3GbLA4+pr2+0=; b=Q89AIVnslHDeNE
	oAskaEkt7FaG9x5K9ljoNX8WFXw0wAYC/HJaCpUHNRH+LwnHuc+VxYosabVmJd/HPl7LjqwLefI//
	AaKstEv/zmXj75yfGKvyAmwJuXt+RxhsoKLwGD5T18O1ytMui7hR6BrnUTRgEeOzcOdlSUUlGd+TY
	/lNqVq+Wfs6uutgYlKGqkEY3wfTvlnc43ZaJ/+6F16YlLBMaDTUjk/h5p6GllzZcREY6FBCaBYVDH
	7Oo8KvFieF76MA4t23k+mgiFX473jbdn6ebHQhJtmc5cNwFmgZ/454dRjIUo4I2lfcbux9Eh5HhTB
	gq949dH48OW6Hf73i5MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggZEj-0000Nv-TM; Mon, 07 Jan 2019 18:02:53 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggZEf-0000MS-JT
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 18:02:51 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 8788DFFD76;
 Mon,  7 Jan 2019 19:02:43 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id W11ZjhyktRhx; Mon,  7 Jan 2019 19:02:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 253C0FFD78;
 Mon,  7 Jan 2019 19:02:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id g_IdK83M7cJM; Mon,  7 Jan 2019 19:02:39 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id DA6AAFFD76;
 Mon,  7 Jan 2019 19:02:38 +0100 (CET)
Message-ID: <d541d82647338c07fa59b0f2ef63880610733505.camel@v3.sk>
Subject: Re: [PATCH v2 17/17] power: supply: olpc_battery: Add OLPC XO 1.75
 support
From: Lubomir Rintel <lkundrak@v3.sk>
To: Darren Hart <dvhart@infradead.org>
Date: Mon, 07 Jan 2019 19:02:37 +0100
In-Reply-To: <20181202233458.GE23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-18-lkundrak@v3.sk> <20181202233458.GE23087@wrath>
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_100249_952973_A38A54BC 
X-CRM114-Status: GOOD (  21.35  )
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
 linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Daniel Mack <daniel@zonque.org>, platform-driver-x86@vger.kernel.org,
 Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 2018-12-02 at 15:34 -0800, Darren Hart wrote:
> On Fri, Nov 16, 2018 at 05:24:03PM +0100, Lubomir Rintel wrote:
> > The battery and the protocol are essentially the same as OLPC XO 1.5,
> > but the responses from the EC are LSB first.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> > Changes since v1:
> > - s/s16 ecword_to_cpu/u16 ecword_to_cpu/
> > - s/u16 ec_byte/u16 ec_word/
> > 
> >  drivers/power/supply/olpc_battery.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> 
> ...
> 
> > @@ -626,6 +635,10 @@ static int olpc_battery_probe(struct platform_device *pdev)
> >  	if (ecver > 0x44) {
> >  		/* XO 1 or 1.5 with a new EC firmware. */
> >  		data->new_proto = 1;
> > +	} else if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
> 
> This if/else blocks concerns me a bit, but I might just be missing some
> context.
> 
> This tests both ecver as well as the OF compatible string, is this reliable? Do
> we know that for all xo1.75-ec compatible nodes the ecver will be <= 0x44? Or,
> is ecver undefined? If the latter, then perhaps this test should be performed
> first?
> 
> if (of_find_compatible_node....x01.75-ec...)
> 	...
> else if (ecver > 0x44)
> 	...
> else
> 	...
> 
> And what happens when ecver == 0x44? We test for > and < but not ==, <=,
> or >= in this block

You're right, the conditionals are not correct. On XO 1.75 the
versioning is different (now at level 0x05) and uninteresting,
therefore the XO 1.75 check needs to go first.

On XO 1 and XO 1.75, we don't support < 0x44. 0x44 is okay, though uses
stays with an old protocol, and > 0x44 uses a new protocol.

Will follow up with a new version of the patch soon.

> 
> > +		/* XO 1.75 */
> > +		data->new_proto = 1;
> > +		data->little_endian = 1;
> >  	} else if (ecver < 0x44) {
> >  		/*
> >  		 * We've seen a number of EC protocol changes; this driver
> > -- 
> > 2.19.1

Thanks
Lubo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
