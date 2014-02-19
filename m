From: tj@kernel.org (Tejun Heo)
Date: Wed, 19 Feb 2014 09:58:39 -0500
Subject: [PATCH v6 07/18] ahci-platform: "Library-ise" ahci_probe
 functionality
In-Reply-To: <1392811320-3132-8-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-8-git-send-email-hdegoede@redhat.com>
Message-ID: <20140219145839.GF10134@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:01:49PM +0100, Hans de Goede wrote:
> ahci_probe consists of 3 steps:
> 1) Get resources (get mmio, clks, regulator)
> 2) Enable resources, handled by ahci_platform_enable_resouces
> 3) The more or less standard ahci-host controller init sequence
> 
> This commit refactors step 1 and 3 into separate functions, so the platform
> drivers for AHCI implementations which need a specific order in step 2,
> and / or need to do some custom register poking at some time, can re-use
> ahci-platform.c code without needing to copy and paste it.
> 
> Note that ahci_platform_init_host's prototype takes the 3 non function
> members of ahci_platform_data as arguments, the idea is that drivers using
> the new exported utility functions will not use ahci_platform_data at all,
> and hopefully in the future ahci_platform_data can go away entirely.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Heh, the lack of comments is getting kinda impressive. :)

Thanks.

-- 
tejun
