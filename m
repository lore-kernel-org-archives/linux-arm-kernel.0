From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Mar 2016 13:44:26 +0100
Subject: [PATCH] ARM: mvebu: Fix of_clk_get() call in a non sleeping
 context
In-Reply-To: <20160308205050.GN19428@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 8 Mar 2016 20:50:51 +0000")
References: <1457446733-7137-1-git-send-email-gregory.clement@free-electrons.com>
 <20160308164117.2a3ed3a7@free-electrons.com>
 <87a8m93pt0.fsf@free-electrons.com>
 <20160308173134.22a3ad64@free-electrons.com>
 <8760wx3oy4.fsf@free-electrons.com>
 <20160308205050.GN19428@n2100.arm.linux.org.uk>
Message-ID: <87fuvy33kl.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On mar., mars 08 2016, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Tue, Mar 08, 2016 at 05:38:11PM +0100, Gregory CLEMENT wrote:
>> And from clk_enable comment we have:
>> ""
>> clk_enable must not sleep, which differentiates it from clk_prepare.  In a
>> simple case, clk_enable can be used instead of clk_prepare to ungate a clk
>> if the operation will never sleep.
>> ""
>> 
>> Moreoever for me the "must" was to insist to the order of the call no to
>> the fact that both must be called.
>
> As the author of the clk API, the idea here is that clk_prepare()
> should always be called _before_ clk_enable() for any clock: in
> other words, getting a clock and then calling clk_enable() on it
> is not legal.
>
> CCF presently enforces this - clk_enable() without a preceding
> clk_prepare() will return -ESHUTDOWN.

Thanks for the clarification, I will work on a alternative solutioin.

Gregory

>
> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
