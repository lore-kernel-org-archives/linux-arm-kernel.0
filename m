From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 6 Dec 2017 14:29:02 -0800
Subject: [PATCH 03/45] drivers: gpio: remove duplicate includes
In-Reply-To: <1512439104-15507-1-git-send-email-pravin.shedge4linux@gmail.com>
References: <1512439104-15507-1-git-send-email-pravin.shedge4linux@gmail.com>
Message-ID: <CADtm3G4BsFfxvqXed-jmw5jPD5ZibNwFir7-k3XHU=+LEhyvWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pravin,

On Mon, Dec 4, 2017 at 5:58 PM, Pravin Shedge
<pravin.shedge4linux@gmail.com> wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.
>
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
> ---
>  drivers/gpio/gpio-brcmstb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> index 545d43a..f40ec39 100644
> --- a/drivers/gpio/gpio-brcmstb.c
> +++ b/drivers/gpio/gpio-brcmstb.c
> @@ -11,7 +11,6 @@
>   * GNU General Public License for more details.
>   */
>
> -#include <linux/bitops.h>

Please remove the second entry at the end of the include list instead
of this one, since that is the duplicate added accidentally in
d74423687f9d70417bfec68121cbd35f79bb170f "gpio: brcmstb: Do not use
gc->pin2mask()" [1].

>  #include <linux/gpio/driver.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>

Thanks,
Gregory

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpio/gpio-brcmstb.c?id=d74423687f9d70417bfec68121cbd35f79bb170f
