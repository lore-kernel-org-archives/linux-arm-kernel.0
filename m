From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 2 Aug 2013 10:28:53 +0530
Subject: [RFC] ARM: spear: remove spear13xx_secondary_startup from INIT
 section.
In-Reply-To: <1375360601-24591-1-git-send-email-srinivas.kandagatla@st.com>
References: <1375360601-24591-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <CAOh2x=nyN5TwsAMrt2-4-2cBjBG0W9X8fMeBJwvTTKJJzsxBBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi..

s/spear/SPEAr

On Thu, Aug 1, 2013 at 6:06 PM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>
> This patch removes spear13xx_secondary_startup fromm _INIT section, there are

s/fromm/from

> two  reasons for this removal.
>  1. discarding such a small code does not save much, given the RAM sizes.
>  2. Having this code discarded, creates corruption issue when we boot
> smp-kernel with nr_cpus=1 or with single cpu node in DT.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
> Hi,
>
> I did encounter corruption issues on STi CA9 SOCs when a SMP kernel is booted with
> nr_cpus=1. This boiled down to freeing the __INIT section of the secondary
> startup code. It looks like two other SOCs(Spear and ux500) might have same
> issue.
>
> Do you think this patch is valid for Spear?
>
> Thanks,
> srini
>
>  arch/arm/mach-spear/headsmp.S |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-spear/headsmp.S b/arch/arm/mach-spear/headsmp.S
> index ed85473..aad3253 100644
> --- a/arch/arm/mach-spear/headsmp.S
> +++ b/arch/arm/mach-spear/headsmp.S
> @@ -13,8 +13,6 @@
>  #include <linux/linkage.h>
>  #include <linux/init.h>
>
> -       __INIT
> -
>  /*

Honestly speaking, I haven't written this piece of code and the person who
wrote it also copied it from Tegra (probably), I believe. And so even he
might not have the exact picture in mind.

I would let the other three guys in cc to speak on our behalf :)
If they don't have a issue with it, then I would be happy to
Ack it :)

--
viresh
