From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Jun 2015 22:48:18 +0100
Subject: [PATCH 1/9] arm: select different compiler flags for ARM CortexM3
In-Reply-To: <1435094387-20146-2-git-send-email-pawelo@king.net.pl>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl>
 <1435094387-20146-2-git-send-email-pawelo@king.net.pl>
Message-ID: <20150623214818.GF7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 11:19:39PM +0200, Paul Osmialowski wrote:
> This one is inspired by two commits published on Emcraft git repo:
> 
> https://github.com/EmcraftSystems/linux-emcraft.git
> 
> 1) 6302b692f570ff9d5645a6e72c11f87b0c1aa409
>  RT #62654. Fixed kernel crashes while running httpd by enabling
>  "-mfix-cortex-m3-ldrd" compiler option, which prevents compiler from
>  generating code like 'ldrd Ra, Rb, [Ra, #Imm]' - according to the 602117
>  Cortex-M3 Errata it may result in incorrect base register when interrupted
>  or faulted.
> 
> by: Yuri Tikhonov <yur@emcraft.com>
> 
> 2) 359d3cda84c01c0f3fae1a519b97a31f318f57ab
>  RT #62654. Removed "--march=..." leaving only "-mcpu=cortex-m3" to make
>  sure only the correct instructions will be generated.
> 
> by: Sergei Poselenov <sposelenov@emcraft.com>
> 
> I reworked these patches to make them less intrusive.
> 
> Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>

NAK.

The EFM32 code already added core support for Cortex-M3 cores, under
the symbol CPU_V7M.  Rather than implementing a whole new set of
Cortex-M3 support alongside the existing code, please work with the
EFM32 maintainer (Uwe Kleine-K?nig) to come up with a common set of
core changes that you can all agree on for Cortex-M3.

Please also try to be a little smarter with whom you're sending your
patches to, the Cc list looks to be excessively long - having soo many
recipients on your message is a good way to get your message rejected
by mailing lists as spam.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
