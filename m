From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 1 Jul 2016 10:32:11 -0700
Subject: [PATCH] ARM: brcmstb: Add earlyprintk support using run-time
 checks
In-Reply-To: <1467333764-2900-1-git-send-email-f.fainelli@gmail.com>
References: <1467333764-2900-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <5776A91B.1000401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2016 05:42 PM, Florian Fainelli wrote:
> SUN_TOP_CTRL_FAMILY_ID is at a fixed absolute address for all of our supported
> chips, so utilize its value to determine what the UARTA base address should be.
> 
> Since the code is called both during decompressor when the MMU is off, and
> after the MMU has been turned on, and we want to do the lookup only
> once, we use the same technique as tegra.S and have a shared storage
> location between the decompressor and the kernel.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Looks like I missed an update to DEBUG_UNCOMPRESS to make it disbaled if
DEBUG_BRCMSTB_UART is enabled.

Should patches to Kconfig.debug be submitted to RMK's patch system, or
pulled via arm-soc changes?

Thanks
-- 
Florian
