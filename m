From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 6 Jun 2013 17:56:53 +0530
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
Message-ID: <CABb+yY2SFfejMbbYOebMCUuMtAZF3u-yc+6z_MJTG2oOeSwL_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 12:58 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> Boot loaders on some Tegra devices can be unlocked but do not let the
> system operate without SecureOS. SecureOS prevents access to some
> registers and requires the operating system to perform certain
> operations through Secure Monitor Calls instead of directly accessing
> the hardware.
>
IOW, some critical h/w controls on Tegra are accessible only from
Secure mode (not unusual). So if we(Linux) run in NS mode we need to
make calls to the SecureOS, over SMC, to do things for us?

> This patch introduces basic SecureOS support for Tegra. SecureOS support
> can be enabled by adding a "nvidia,secure-os" property to the "chosen"
> node of the device tree.
>
Probably just a nit, but shouldn't it be "nvidia,nonsecure-os"
instead, denoting the mode Linux is going to run?  (and then I wonder
if we could detect the mode (S or NS) at runtime and avoid this flag
at all).

Cheers,
-Jassi
