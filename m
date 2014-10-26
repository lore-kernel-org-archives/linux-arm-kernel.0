From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Oct 2014 08:15:35 +0800
Subject: [PATCH v2] arm: dts: add initial support for TBS2910 Matrix ARM
 mini PC
In-Reply-To: <544BE2E6.4040903@web.de>
References: <1413635236-3825-1-git-send-email-smoch@web.de>
 <1413922998-4371-1-git-send-email-smoch@web.de>
 <20141025153321.GA5321@tiger> <544BE2E6.4040903@web.de>
Message-ID: <20141026001532.GA6973@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Sebastian for clarifying things.  This leaves me only one to
reply.

On Sat, Oct 25, 2014 at 07:50:30PM +0200, Soeren Moch wrote:
> >> +&snvs_poweroff {
> >> +	status = "okay";
> >> +};
> > 
> > Is snvs_poweroff already available in <soc>.dtsi?
> 
> I read some discussions about it and thought it is or at least will be
> there before my patch is applied. But I'm very sure that you know this
> better than me.
> Do you suggest to remove this node?

We have to remove this node, because if I apply the patch on my tree,
I get the following error when compiling the DTS.

  DTC     arch/arm/boot/dts/imx6q-tbs2910.dtb
Error: ../arch/arm/boot/dts/imx6q-tbs2910.dts:350.2-3 label or path, 'snvs_poweroff', not found
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [arch/arm/boot/dts/imx6q-tbs2910.dtb] Error 1
make[1]: *** [dtbs] Error 2

I'm saying snvs_poweroff node is not available on mainline tree yet.
You must have generated the patch against some tree without additional
patches applied?

Shawn
