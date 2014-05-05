From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 5 May 2014 11:36:54 -0400
Subject: [PATCH v2 0/5] ARM: mvebu: fixes and improvements for 375 support
In-Reply-To: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140505153654.GO28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 05:05:21PM +0200, Thomas Petazzoni wrote:
> Hello Jason,
> 
> Here are five patches making fixes and improvements to the Armada 375
> support. They are related to the fact that we now have access to
> Armada 375 A0 boards (however, Ezequiel still only has access to a Z1
> platform, so we would like to keep Z1 support for now).
> 
>  * Patch 1 is really a fix. It fixes the thermal related quirk that
>    was added by Ezequiel, to make sure it really works on A0 revision.
> 
>  * Patch 2 to 5 make the SMP and coherency workarounds conditional on
>    the Armada 375 Z1. The condition on SMP is really mandatory to get
>    SMP working on A0. For coherency, the WA could be used on A0, but
>    it is useless and hurt performance.
> 
> The series is based on your mvebu/soc branch.
> 
> Changes since v1:
> 
>  * Made the dev and rev variable local to the appropriate if() block
>    in PATCH 5.
> 
>  * Re-added the "Booting CPU" message in PATCH 4, which was
>    mistakently removed in v1.
> 
>  * Extended the git commit message of PATCH 4 to explain why we're
>    moving things from ->smp_prepare_cpus() to ->smp_boot_secondary().
> 
>  * Added Ezequiel's Acked-by on PATCH 1.
> 
> Thanks,
> 
> Thomas
> 
> Thomas Petazzoni (5):
>   ARM: mvebu: fix thermal quirk SoC revision check
>   ARM: mvebu: initialize mvebu-soc-id earlier
>   ARM: mvebu: add Armada 375 A0 revision definition
>   ARM: mvebu: conditionalize Armada 375 SMP workaround
>   ARM: mvebu: conditionalize Armada 375 coherency workaround

hmmm, I didn't get #5...

thx,

Jason.
