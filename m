From: b-liu@ti.com (Bin Liu)
Date: Tue, 19 Dec 2017 11:22:20 -0600
Subject: [PATCH 1/2] usb: musb: un-break davinci glue layer
In-Reply-To: <20171208192355.32735-1-amery@hanoverdisplays.com>
References: <20171208192355.32735-1-amery@hanoverdisplays.com>
Message-ID: <20171219172220.GD14090@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alejandro,

On Fri, Dec 08, 2017 at 07:23:54PM +0000, Alejandro Mery wrote:
> MUSB's davinci glue was made to depend on BROKEN by Felipe Balbi back in
> 2013 because of lack of active development. needed changes were actually trivial
> 
> Fixes: 787f5627bec8 (usb: musb: make davinci and da8xx glues depend on BROKEN)
> Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>

Thanks for the effort to re-enable this driver. But due to lack of
development, other than the phy and fifo mode which you try to fix with
these two patches, the driver still doesn't fit in the current driver
framework, for example,

- the driver depends on mach/ header for CPU and board type;
- clk control is not separated;
- gpio control vbus should use extcon driver;

So I feel it is not ready to un-broken it yet, unless others have
different opinion.

But I could take these two patches if not remove BROKEN from Kconfig.

Regards,
-Bin.
