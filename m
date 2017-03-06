From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Mar 2017 10:06:39 +0100
Subject: [PATCH] clk: sunxi-ng: tighten SoC deps on explicit AllWinner SoCs
In-Reply-To: <20170302174357.6246-1-pbrobinson@gmail.com>
References: <20170302174357.6246-1-pbrobinson@gmail.com>
Message-ID: <20170306090639.aubg4ixtt7f4kb5s@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 02, 2017 at 05:43:57PM +0000, Peter Robinson wrote:
> Tighten the depends on the various AllWinn SoCs so we don't
> inadvertantly get clock drivers when we're not wanting them
> like 32 bit SoC clocks for 64 bit configs. Ensure there's
> still test coverage though.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

It turns out that this was making Kconfig crash, because the keyword
is depends on and not depends.

I fixed it, but please make sure the syntax is correct next time.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170306/71c49958/attachment.sig>
