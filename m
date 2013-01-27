From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sun, 27 Jan 2013 01:42:00 +0100
Subject: [PATCH 09/19] mfd/twl4030: don't warn about uninitialized return
 code
In-Reply-To: <1359153858-31992-10-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-10-git-send-email-arnd@arndb.de>
Message-ID: <20130127004200.GJ1174@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Jan 25, 2013 at 10:44:08PM +0000, Arnd Bergmann wrote:
> If the twl4030_write_script function gets called with
> a zero length argument, its return value does not
> get set. We know that all scripts have a nonzero
> length, but returning an error in case they ever
> do is probably appropriate.
> 
> Without this patch, building omap2plus_defconfig results in:
> 
> drivers/mfd/twl4030-power.c: In function 'load_twl4030_script':
> drivers/mfd/twl4030-power.c:414:5: error: 'err' may be used uninitialized in this function
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: "Kristo, Tero" <t-kristo@ti.com>
> ---
>  drivers/mfd/twl4030-power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to my for-linus branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
