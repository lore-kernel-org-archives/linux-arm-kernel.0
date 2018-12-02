Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C8AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:35:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF9D20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kXbGFlrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF9D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PrgOFz/NKjzrwnYR080n3PIqLGoqD9ZdjCnQAflq6Pw=; b=kXbGFlrsRkPPqa
	TW3fjeBsoQSw6sAW2OOZicazrQ3dz1AwGwJWUDWuYrk/neKrErzfs1K72b5+VCKxJo2vJOOvetLLJ
	Sj8KmzgDmA2FF3AU1WGf3/uAiOqCWUY6/eqgjAnBuI4CisWiYL/OLJmbFIwFPAhTwdr20aRuiCBrn
	OFGc8q2/HVPPYFxEQ531+fvJ4KQOeqiaWocSnbErTK0fK1JgT8F17MpPTjcwD12itKLLYICbjgZGV
	H4H2LKzXMeH8Axp0b1c70WE/f8ArxnLW3wXOtHLwCrehvkxtn7ANEHYl9z0Od2ilIUhaaWdJJwS4q
	79mBjjm7p/wuJsv8ZHTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTbGS-00056T-C9; Sun, 02 Dec 2018 23:35:04 +0000
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2
 (Red Hat Linux)) id 1gTbGN-0004uO-CA; Sun, 02 Dec 2018 23:34:59 +0000
Date: Sun, 2 Dec 2018 15:34:58 -0800
From: Darren Hart <dvhart@infradead.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 17/17] power: supply: olpc_battery: Add OLPC XO 1.75
 support
Message-ID: <20181202233458.GE23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-18-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-18-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Fri, Nov 16, 2018 at 05:24:03PM +0100, Lubomir Rintel wrote:
> The battery and the protocol are essentially the same as OLPC XO 1.5,
> but the responses from the EC are LSB first.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - s/s16 ecword_to_cpu/u16 ecword_to_cpu/
> - s/u16 ec_byte/u16 ec_word/
> 
>  drivers/power/supply/olpc_battery.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c

...

> @@ -626,6 +635,10 @@ static int olpc_battery_probe(struct platform_device *pdev)
>  	if (ecver > 0x44) {
>  		/* XO 1 or 1.5 with a new EC firmware. */
>  		data->new_proto = 1;
> +	} else if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {

This if/else blocks concerns me a bit, but I might just be missing some
context.

This tests both ecver as well as the OF compatible string, is this reliable? Do
we know that for all xo1.75-ec compatible nodes the ecver will be <= 0x44? Or,
is ecver undefined? If the latter, then perhaps this test should be performed
first?

if (of_find_compatible_node....x01.75-ec...)
	...
else if (ecver > 0x44)
	...
else
	...

And what happens when ecver == 0x44? We test for > and < but not ==, <=,
or >= in this block

> +		/* XO 1.75 */
> +		data->new_proto = 1;
> +		data->little_endian = 1;
>  	} else if (ecver < 0x44) {
>  		/*
>  		 * We've seen a number of EC protocol changes; this driver
> -- 
> 2.19.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
