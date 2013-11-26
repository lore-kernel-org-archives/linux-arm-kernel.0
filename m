From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 19:09:22 -0600
Subject: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in
 DT only mode
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Message-ID: <20131126010922.GA21580@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 25, 2013 at 04:14:15PM -0800, Tony Lindgren wrote:
> Hi all,
> 
> We can finally make mach-omap2 to boot in device tree only mode for v3.14.
> 
> By doing that, we can get rid of about 20000 lines of legacy code for v3.14
> that's no longer needed with device tree :) And that's not counting the
> additional removal of the code that comes with the pending patches to
> move clocks to drivers/clk.
> 
> Looks like we still have some legacy boards that don't have a .dts file,
> so if you're using one, please post the .dts file. I've posted some quick
> instructions in the first patch of this series for bringing up omaps with
> device tree.
> 
> For most omap2+ boards that are not yet supported with device tree just
> the .dts file is needed. Some boards also may need additional entries to
> pdata-quirks.c. If there are more complicated issues, please let me know
> so we can sort out those issues ASAP.
> 
> I don't have all omap boards so I have not been able to do a .dts file
> for those. Some help would be appreciated there if you are using a
> board with no .dts file posted yet. I can naturally help too where
> possible so we get the devices working with device tree as needed :)
> 
> These patches need v3.13-rc1 and some of the following patches
> depending on your board:
> 
> [PATCH 0/8] Various omap device tree usability fixes for v3.13 merge window
> [PATCH 00/11] Make omap24xx booting device tree based for v3.14 merge window
> [PATCH 0/3] Yet more fixes for booting omaps with device tree
> [PATCH 0/5] Prepare making omap3 device tree only and convert LDP
> 
> I've also pushed all the patches into a temporary testing branch:
> 
> omap-for-v3.14/tmp-testing-unstable-not-immutable
> 
> Regards,
> 
> Tony
> 
> 
> Tony Lindgren (12):
>   ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2
>     DT only for booting

looks like this patch didn't make it to the list, maybe it's too large ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/e481c047/attachment-0001.sig>
