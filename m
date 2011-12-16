From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 16 Dec 2011 01:40:52 -0700 (MST)
Subject: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
In-Reply-To: <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
 <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com>
Message-ID: <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

> -  The reset in the driver at init is not needed anymore as the
>    hwmod framework takes care of reseting it.
> -  Reset is removed from omap_i2c_init, which was called
>    not only during probe, but also after time out and error handling.
>    device_reset were added in those places to effect the reset.
> -  Earlier the hwmod SYSC settings were over-written in the driver.
>    Removing the same and letting the hwmod take care of the settings.
> -  Clean up the SYSS_RESETDONE_MASK macro as it is no longer needed.
> -  Clean up the SYSCONFIG SYSC bit definition macros.
> -  Fix the typos in wakeup.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   83 +++++++++++-----------------------------
>  1 files changed, 23 insertions(+), 60 deletions(-)

This patch either needs to be acked by Ben with a note that it's okay for 
us to merge through the OMAP tree, or needs to be merged by Ben during the 
3.4 merge window, after patches 1-3 have reached the mainline tree.


- Paul
