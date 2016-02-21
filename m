From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 21 Feb 2016 09:18:30 -0800
Subject: [PATCH v3] Fix sun7i pin assignment for IRQ's
In-Reply-To: <1456060845-20692-1-git-send-email-henry@nitronetworks.nl>
References: <1456060845-20692-1-git-send-email-henry@nitronetworks.nl>
Message-ID: <20160221171830.GD19169@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 21, 2016 at 02:20:41PM +0100, Henry Paulissen wrote:
> After testing IRQ pins we found some bugs in the pinctrl declaration.

Your commit log is going to need some work. Which bugs? What tests did
you make? Why are you making these changes while the datasheet says
otherwise?

> Signed-off-by: Henry Paulissen <henry@nitronetworks.nl>
> ---
> 
> Changes in v2:
>     After some more testing we found irq on PI pins.
>     they where on mux6 so this is included in my patch.
> 
>     Also included is a warning for PI17, this pin was not working
>     on apritzel his bPI and he thinks it might be correlated to
>     GIC and IRQ 29.
> 
> Changes in v3:
>     Changed name from nickname to realname in email and SoB.
> ---
>  drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
> index cf1ce0c..0fe173e 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
> @@ -344,25 +344,21 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>  		  SUNXI_FUNCTION(0x2, "nand0"),		/* NCE4 */
>  		  SUNXI_FUNCTION(0x3, "spi2"),		/* CS0 */
> -		  SUNXI_FUNCTION_IRQ(0x6, 12)),		/* EINT12 */

Have you tried to compile it?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160221/485c87f8/attachment.sig>
