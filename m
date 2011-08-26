From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 Aug 2011 22:04:31 -0700
Subject: [PATCH v3 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
References: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
Message-ID: <CAOesGMiygfaNkPa7uURCiJpC=WDinWhKi07LFgJ+5JoGW_fLKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 4:43 PM, Stephen Warren <swarren@nvidia.com> wrote:
> v3:
> * Build on Jamie Iles' patches to split some of the DT parsing into
> ?common code.
> * Renamed some properties to remove "nvidia," from name; they can be
> ?generic.
> * Support pins property, to apply DT nodes to multiple pins/groups
> * Some minor error-message changes driven by some of the above.
> * Removed requirement to #ifdef CONFIG_OF
> * Removed AUXDATA table entries in mach-tegra/board-dt.c
>
> TODO:
> * Convert from using strings to using integers for the function and pin
> ?names. This relies on the dtc patches I posted yesterday, but should
> ?be pretty simple once they're in.
>
> Jamie Iles (1):
> ?of: add a generic pinmux helper
>
> Stephen Warren (12):
> ?arm/tegra: Prep boards for gpio/pinmux conversion to pdevs
> ?docs/dt: Document nvidia,tegra20-gpio's nvidia,enabled-gpios property
> ?arm/dt: Tegra: Add nvidia,enabled-gpios property to GPIO controller
> ?docs/dt: Document nvidia,tegra20-pinmux binding
> ?arm/dt: Tegra: Add pinmux node
> ?dt: add empty for_each_child_of_node, of_find_property
> ?gpio/tegra: Convert to a platform device
> ?gpio/tegra: Add device tree support
> ?arm/tegra: Convert pinmux driver to a platform device
> ?of: add property iteration helpers
> ?arm/tegra: Add device tree support to pinmux driver
> ?arm/tegra: board-dt: Remove dependency on non-dt pinmux functions


This is looking pretty sane to me.

Grant, how do you prefer to handle this, since it spans of/dt, gpio
and tegra code? I can start a topic branch for Arnd to pull in for the
tegra parts, would you prefer picking up the of helper functions on
your own or is an ack from you and merge through the arm-soc tree
easier?


-Olof
