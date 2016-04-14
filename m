From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Apr 2016 16:48:40 +0100
Subject: [PATCH v4 0/2] ARM64: Enable SP805 WDT support for FSL LS2080A
In-Reply-To: <1451296884-7932-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1451296884-7932-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <570FBBD8.4030704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,

On 28/12/15 10:01, Bhupesh Sharma wrote:
> Hi Arnd, Kevin, Olof
> 
> This is the v4 of patchset which adds the support for SP805 WDT on FSL LS2080A
> and also adds the missing documentation of SP805 WDT device-tree bindings.
> 
> Rebased against arm-soc/next/dt
> 
> Changes since v3:
> (v3 can be viewed here: https://www.mail-archive.com/devicetree at vger.kernel.org/msg97249.html)
> - Added Rob's Acked-by for patch 1/2.
> - Sending to 'arm at kernel.org' list and also cc'ed Shawn Guo
> 
> Changes since v2:
> (v2 can be viewed here: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/463141)
> - Addressed Rob's comments regarding the second mandatory CLK source's
>   (WDOGCLK) name in the bindings.
> 
> Changes since v1:
> (v1 can be viewed here: http://www.spinics.net/lists/devicetree/msg102487.html)
> 
> - Addressed Rob and Mark's comments regarding the mandatory CLK sources
> - Removed interrupt property from the bindings for now (as discussed
>   with Mark on IRC) till Will's patch proceeds further and enables
>   handling the WDOG interrupts for each core connected to the same PPI
>   line (http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/391616.html)

Will just pointed me to this series. I've recently posted a set of
patches that should be able to deal with the quirkiness of your HW with
regards to PPIs:

http://thread.gmane.org/gmane.linux.drivers.devicetree/163464

Could you please let me know if this works for you?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
