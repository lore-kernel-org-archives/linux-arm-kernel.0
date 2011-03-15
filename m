From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 15 Mar 2011 11:44:22 +0800
Subject: [PATCH] ARM:boot:device tree: Allow the device tree binary to
	be appended to zImage
In-Reply-To: <20110309215800.26377.43925.stgit@riker>
References: <20110309215800.26377.43925.stgit@riker>
Message-ID: <20110315034421.GE11098@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 01:58:00PM -0800, John Bonesio wrote:
> This patch provides the ability to boot using a device tree that is appended
> to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> ---
> 
>  arch/arm/Kconfig                |    7 ++++
>  arch/arm/boot/compressed/head.S |   75 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 79 insertions(+), 3 deletions(-)
> 
I played this patch on mx51 babbage a little bit, and noticed that it
introduces one difference on both non-dt and dt kernel booting.  The
serial terminal stalls for a few seconds after printing
'Uncompressing Linux...', and then continue to work with all message
output.  That's something like:

Uncompressing Linux... (stall for seconds) done, booting the kernel.
Linux version 2.6.38-rc6+ (r65073 at S2101-09) (gcc version 4.4.5 (Ubuntu/Linaro 4.
4.4-14ubuntu4) ) #91 Tue Mar 15 11:29:03 CST 2011
CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale MX51 Babbage Board
Machine: Freescale MX51 Babbage Board
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
......

I'm unsure if this is expected ...

-- 
Regards,
Shawn
