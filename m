Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C914DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:58:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA5720672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HAnuWfhn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM5WL9+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA5720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7nld1Rm7P18gpn93Vw8rCOi+D3Ww0aDN+xujOroLK9M=; b=HAnuWfhnWQUQZX
	+WKuHPOSP3yWnBSa27b6jn7qSfsIvhy81XgcmL7ITQzaduXX4LTTBZyMXogN5Y/CE8CEc54eo8fWd
	ht3Q7/8pnI/b89FOydJH3yJpgZ6LftEe3SLQqAC/9472iwS0OWdfLBNLSHkpJA0RHdHBljgbXE9ns
	I5iUqjeP7jXcV6tswN9/eBYBCJNTlIg8x6ZZhQkG+nKRtuVL2NYwnGbK+jszClw8RvNO0wVYTw3CE
	BpUryRce/ooCb0KS0jfNIvAdHWuSQQgf4t3hFtbbH5pYAcruDdLh+MU4hhKcfJvJxl6mjwWaZ8HoF
	9lwYtWflIfx0kzqa7PhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuAK-0002WN-0Y; Thu, 06 Dec 2018 13:58:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuAF-0002W1-49
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:58:06 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 47A6A20672;
 Thu,  6 Dec 2018 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544104672;
 bh=Lko00ZMHeQ9UyWtpAATwV1yro16ZAXH88yCaSak3QhE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SM5WL9+4uxRBpg6NgF+rjzsc0mbqRHLA/XWk1+8HtfVGoZrUG3OFlEiopa0/Bh1UZ
 7DGJs2y6BbU56G6rPNp7IWfGzQgxrlJYnB9jReuhhOKjL9lWXf4r/HrpvpCgLT0edB
 RPAHtHpWThcRiQwNISmrrTFzaf9ysTaM3KHAfDqQ=
Date: Thu, 6 Dec 2018 21:57:08 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [shawnguo:imx/soc 2/2] arch/arm/Kconfig.debug:1445: syntax error
Message-ID: <20181206135706.GA12929@dragon>
References: <201812062028.Xnf6p6GZ%fengguang.wu@intel.com>
 <20181206130617.c3x353tgwyxjszc4@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206130617.c3x353tgwyxjszc4@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_055803_182700_F2D53739 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: kernel@pengutronix.de, kbuild test robot <lkp@intel.com>,
 linux-arm-kernel@lists.infradead.org, kbuild-all@01.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 02:06:17PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
> =

> On Thu, Dec 06, 2018 at 08:44:30PM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.=
git imx/soc
> > head:   911dccedb00e5b45cf2d0fafc21aba233b58e115
> > commit: 911dccedb00e5b45cf2d0fafc21aba233b58e115 [2/2] ARM: debug-imx: =
only define DEBUG_IMX_UART_PORT if needed
> > config: arm-hackkit_defconfig
> > compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 911dccedb00e5b45cf2d0fafc21aba233b58e115
> >         GCC_VERSION=3D7.2.0 make.cross ARCH=3Darm  hackkit_defconfig
> >         GCC_VERSION=3D7.2.0 make.cross ARCH=3Darm =

> > =

> > All errors (new ones prefixed by >>):
> > =

> > >> arch/arm/Kconfig.debug:1445: syntax error
> > >> arch/arm/Kconfig.debug:1444: invalid option
> =

> hmm, I was sure I tested that, but I can confirm it fails for me, too.
> =

> The obvious fix is:
> =

> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 3f057593db01..c253a4e79868 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1441,18 +1441,18 @@ config DEBUG_OMAP2PLUS_UART
>  =

>  config DEBUG_IMX_UART_PORT
>  	int "i.MX Debug UART Port Selection"
> -	depends on DEBUG_IMX1_UART ||
> -		   DEBUG_IMX25_UART ||
> -		   DEBUG_IMX21_IMX27_UART ||
> -		   DEBUG_IMX31_UART ||
> -		   DEBUG_IMX35_UART ||
> -		   DEBUG_IMX50_UART ||
> -		   DEBUG_IMX51_UART ||
> -		   DEBUG_IMX53_UART ||
> -		   DEBUG_IMX6Q_UART ||
> -		   DEBUG_IMX6SL_UART ||
> -		   DEBUG_IMX6SX_UART ||
> -		   DEBUG_IMX6UL_UART ||
> +	depends on DEBUG_IMX1_UART || \
> +		   DEBUG_IMX25_UART || \
> +		   DEBUG_IMX21_IMX27_UART || \
> +		   DEBUG_IMX31_UART || \
> +		   DEBUG_IMX35_UART || \
> +		   DEBUG_IMX50_UART || \
> +		   DEBUG_IMX51_UART || \
> +		   DEBUG_IMX53_UART || \
> +		   DEBUG_IMX6Q_UART || \
> +		   DEBUG_IMX6SL_UART || \
> +		   DEBUG_IMX6SX_UART || \
> +		   DEBUG_IMX6UL_UART || \
>  		   DEBUG_IMX7D_UART
>  	default 1
>  	help
> =

> @Shawn: Can you squash this into the original commit?

Done.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
