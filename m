From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 27 Aug 2013 17:31:22 +0200
Subject: [PATCHv5 2/3] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <1377272686-13253-2-git-send-email-dinguyen@altera.com>
References: <1377272686-13253-1-git-send-email-dinguyen@altera.com>
 <1377272686-13253-2-git-send-email-dinguyen@altera.com>
Message-ID: <20130827153122.GH24795@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Fri, Aug 23, 2013 at 10:44:45AM -0500, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-mmc at vger.kernel.org
> CC: linux-arm-kernel at lists.infradead.org
> 
> v5:
> - Add "altr,ciu-clk-offset" that represents the necessary offset
>   and shift values in the sysmgr phandle. This is used to set
>   the correct CIU clock values.
> 
> v4:
> - Add a complete binding example in documentations
> - Add a phandle entry for "altr,sysmgr" which links the system
>   manager to the SD/MMC IP block that controls the SDR timings.
> - Split up patches
>         1/3 - Add syscon binding to sys-mgr node
>         2/3 - DTS bindings and documentation for SD/MMC on SOCFPGA
>         3/3 - Driver changes to use the bindings
> 
> v3:
> - Explicitly reference synopsis-dw-mshc.txt for base bindings
> - Remove "dw-mshc-ciu-div" as driver can get clock information dts "ciu" entry
> - Fixed indentation issue
> 
> v2:
> - Remove bus-width and extra line in documentation
> - Merge bindings example into a single node in documentation
> ---

You should put your changelogs here and not above the ---
AFAIK nobody cares for the development history of a patch once it is applied.

>  .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   63 ++++++++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |   11 ++++
>  arch/arm/boot/dts/socfpga_cyclone5.dts             |   14 +++++
>  arch/arm/boot/dts/socfpga_vt.dts                   |   14 +++++
>  4 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
