From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 9 Dec 2014 14:33:39 +0900
Subject: [PATCH v3 3/3] ARM: tegra: Add Tegra124 ACTMON support
In-Reply-To: <1417709696-29281-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1417709696-29281-1-git-send-email-tomeu.vizoso@collabora.com>
 <1417709696-29281-4-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAAVeFu+UZyzF6c+MMnXFAKUbDcw6aan13Sg88c9-YbUsbXYKnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 5, 2014 at 1:14 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> Add device node for the ACTMON block to the Tegra124 device tree.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> ---
>
> v3:     * Address misc. style issues found by Thierry and Alexander
>         * Added helpers for register i/o
>         * Further documented the structs
>         * Enable the ACTMON after the IRQ handler has been installed
>         * Disable the ACTMON before removing the IRQ handler
>         * Add governor in a subsys initcall
>
> v2:     * Add operating-points property
> ---
>  arch/arm/boot/dts/tegra124.dtsi        |  23 +
>  drivers/devfreq/Kconfig                |   7 +-
>  drivers/devfreq/Makefile               |   2 +-
>  drivers/devfreq/tegra-actmon-devfreq.c | 777 +++++++++++++++++++++++++++++++++
>  drivers/devfreq/tegra-devfreq.c        | 718 ------------------------------

In patch 2/3 you create tegra-devfreq.c, to apparently move it to
tegra-actmon-devfreq.c and (seemingly) add somemore lines to it. This
makes things difficult to review, and I am almost sure this is a
naming mistake - could you fix this and resend?
