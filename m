From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Aug 2011 20:36:07 +0100
Subject: [PATCH] ARM: tegra: Fix <mach/gpio.h> to have necessary #includes
In-Reply-To: <1313085952-26365-1-git-send-email-swarren@nvidia.com>
References: <1313085952-26365-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110811193607.GA24166@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 12:05:52PM -0600, Stephen Warren wrote:
> Without this, EINVAL isn't defined, and type bool isn't declared.
> This leads to compilation failures.

An alternative approach would be to convert tegra to be able to use
the gpiolib __gpio_to_irq() for the on-SoC stuff, and eliminate
irq_to_gpio().

Would it be possible to do that instead?
