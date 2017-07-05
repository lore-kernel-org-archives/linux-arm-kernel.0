From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Jul 2017 18:02:58 +0200
Subject: [PATCH 2/3] ASoC: sun4i-i2s: Get startup to call set_fmt
In-Reply-To: <20170705154324.14565-3-codekipper@gmail.com>
References: <20170705154324.14565-1-codekipper@gmail.com>
 <20170705154324.14565-3-codekipper@gmail.com>
Message-ID: <20170705160258.3lzrfmoi4kmbmzb5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 05, 2017 at 05:43:23PM +0200, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The set_fmt function pointer is called during probing and this is whilst
> the block is disabled. It is over writing the default register values with
> the same settings so isn't noticed.
> This wasn't a problem with the older SoCs but with the desire to reuse as
> much functionlity as possible for the newer devices then set_fmt needs to
> be called whilst the block is enabled.

The driver while the block is disabled will use the cache, and will
flush it when the block is enabled so it won't make any difference.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170705/b044c282/attachment.sig>
