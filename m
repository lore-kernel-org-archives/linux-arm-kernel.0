From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 01 Oct 2014 12:36:56 +0200
Subject: [PATCH 2/2] ARM: EXYNOS: PMU: move restart code into pmu driver
In-Reply-To: <1412142540-3667-3-git-send-email-pankaj.dubey@samsung.com>
References: <1412142540-3667-1-git-send-email-pankaj.dubey@samsung.com>
 <1412142540-3667-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <542BD948.8040600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

Please see my comments inline.

On 01.10.2014 07:49, Pankaj Dubey wrote:
> Let's register reboot_notifier from PMU driver for reboot
> functionality. So that we can remove restart hooks from
> machine specific file, and thus moving ahead when PMU moved
> to driver folder, this functionality can be reused for ARM64
> based Exynos SoC's.

[snip]

> +static int pmu_reboot_notify_handler(struct notifier_block *this,
> +		unsigned long code, void *unused)
> +{
> +	if (code == SYS_RESTART) {
> +		u32 val = 0x1;
> +
> +		pmu_raw_writel(val, EXYNOS_SWRESET);

As already mentioned for patch 1, no need for the variable, because this
is just a constant 1.

Best regards,
Tomasz
