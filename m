From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 13 May 2012 12:04:40 -0400
Subject: [PATCH] ARM: integrator: fix typo in PCI swizzle function
In-Reply-To: <1336813546-25766-1-git-send-email-linus.walleij@linaro.org>
References: <1336813546-25766-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAP=VYLrTRQn_MQdB6mVC5qpPB1f6W8Maw8gaPN2TPRDy9c5Nvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2012 at 5:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The next tree didn't compile due to a typo in commit
> cfb32a689949d09f112493de4a1e3e5900db2053
> "ARM: PCI: integrator: use common PCI swizzle"

While the above commit may have played a role, it wasn't the
one that actually caused the final build fail.  I bisected to the
failing commit and sent the same fix for this over a week ago.

http://www.spinics.net/lists/arm-kernel/msg172951.html

Should I also be Cc'ing arm at kernel.org on all prospective
ARM fixes I find in linux-next in the future?

Thanks,
Paul.
---

>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ?arch/arm/mach-integrator/pci.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
> index 40f4b4f..6c1667e 100644
> --- a/arch/arm/mach-integrator/pci.c
> +++ b/arch/arm/mach-integrator/pci.c
> @@ -73,7 +73,7 @@ static u8 __init integrator_swizzle(struct pci_dev *dev, u8 *pinp)
> ? ? ? ?if (*pinp == 0)
> ? ? ? ? ? ? ? ?*pinp = 1;
>
> - ? ? ? return pci_std_swizzle(dev, pinp);
> + ? ? ? return pci_common_swizzle(dev, pinp);
> ?}
>
> ?static int irq_tab[4] __initdata = {
> --
> 1.7.7.6
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
