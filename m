From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Mar 2018 16:09:21 +0100
Subject: [PATCH 2/4] ARM: sunxi: mc-smp: Use DT enable-method for sun9i
 A80 SMP
In-Reply-To: <20180308150012.19045-3-wens@csie.org>
References: <20180308150012.19045-1-wens@csie.org>
 <20180308150012.19045-3-wens@csie.org>
Message-ID: <20180308150921.ftwrbbuhc5fxkchq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 11:00:10PM +0800, Chen-Yu Tsai wrote:
> Instead of having an early init function check the machine compatible
> and installing multi-cluster SMP support for the A80 if it matches,
> use a new cpu enable-method string. This makes the platform support
> future proof in case anyone manages to add PSCI support.
> 
> The original init code for the SMP support is changed into the
> .prepare_cpus callback in the smp_operations structure. Instead of
> panicing when resources are missing like on some platforms, our code
> merely guards against engaging SMP or CPU hotplug and returns an error.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/3883f2fb/attachment.sig>
