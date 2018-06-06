From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 6 Jun 2018 10:18:27 +0200
Subject: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE
 disabled
In-Reply-To: <20180525210843.1821071-1-arnd@arndb.de>
References: <20180525210843.1821071-1-arnd@arndb.de>
Message-ID: <20180606081827.GD11810@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 11:08:30PM +0200, Arnd Bergmann wrote:
> Without dmaengine support, we get a harmless warning about an
> unused function:
> 
> drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but not used [-Werror=unused-function]
> 
> Changing the #ifdef to an IS_ENABLED() check shuts up that warning
> and is slightly nicer to read.
> 
> Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/pwm-stm32.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Lee, I applied this on top of your immutable MFD/PWM branch because it
depends on the capture support that you applied. I wasn't sure what your
PR timing was going to be, so I thought I'd do it this way since I'm
pulling in some last minute fixes for v4.18.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180606/e5ca7938/attachment-0001.sig>
