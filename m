From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 26 Nov 2013 13:44:00 +0100
Subject: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot
 in DT only mode
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Message-ID: <52949790.1010900@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony,

On 11/26/2013 01:14 AM, Tony Lindgren wrote:
> Hi all,
> 
> We can finally make mach-omap2 to boot in device tree only mode for v3.14.
> 
> By doing that, we can get rid of about 20000 lines of legacy code for v3.14
> that's no longer needed with device tree :) And that's not counting the
> additional removal of the code that comes with the pending patches to
> move clocks to drivers/clk.
> 

Great news :)

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

I just tested your tree with my custom Overo-based board (OMAP3630). I
see some new warnings popping up, nothing dramatic at first glance. I
will continue testing to see if I lost something in the transition.

IMHO one remaining issue is the missing binding for the camera interface
(ISP). I saw recently an RFC from Sebastian Reichel to add the necessary
binding [1], but this work will probably take some time. So probably a
quirk is necessary here to bring up this IP.

Best regards,

Florian

[1]
http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/70533
