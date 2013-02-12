From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 12 Feb 2013 11:07:47 +0100
Subject: [PATCH] ARM: OMAP3+: Fix kernel panic on boot
In-Reply-To: <1360614380-20114-1-git-send-email-jon-hunter@ti.com>
References: <1360614380-20114-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20130212100747.GA20996@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Mon, Feb 11, 2013 at 02:26:19PM -0600, Jon Hunter wrote:
> Commit 8a6aaa3 (mfd: twl-core: Collect global variables behind one
> private structure (global)) removed the variable "inuse" that is used
> to determine if the device has been initialised and now use the
> twl_priv structure instead. This is causing the kernel to panic on
> OMAP3+ devices using the twl driver, because we try to access the
> twl_priv->ready member before checking if twl_priv is initialised. Fix
> this and move this test to the beginning of the twl_i2c_read/write
> function because twl_get_last_module() also uses the twl_priv structure.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/mfd/twl-core.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
Patch applied, thanks.
I fixed the subject as it's codewise not ARM or OMAP3 related, but rather mfd
and twl-core.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
