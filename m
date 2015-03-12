From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Mar 2015 08:25:32 +0000
Subject: [PATCH v6] ARM: imx6: convert GPC to stacked domains
In-Reply-To: <20150312022613.GE20455@dragon>
References: <1426088672-15587-1-git-send-email-marc.zyngier@arm.com>
 <20150312022613.GE20455@dragon>
Message-ID: <55014D7C.2030304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 12/03/15 02:26, Shawn Guo wrote:
> On Wed, Mar 11, 2015 at 03:44:32PM +0000, Marc Zyngier wrote:
>> IMX6 has been (ab)using the gic_arch_extn to provide
>> wakeup from suspend, and it makes a lot of sense to convert
>> this code to use stacked domains instead.
>>
>> This patch does just this, updating the DT files to actually
>> reflect what the HW provides.
>>
>> BIG FAT WARNING: because the DTs were so far lying by not
>> exposing the fact that the GPC block is actually the first
>> interrupt controller in the chain, kernels with this patch
>> applied wont have any suspend-resume facility when booted
>> with old DTs, and old kernels with updated DTs won't even boot.
>>
>> Tested-by: Stefan Agner <stefan@agner.ch>
>> Acked-by: Stefan Agner <stefan@agner.ch>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>> * From v5:
>> - Added a big fat warning when an old DT is detected (as requested by Jason)
>> - Allow interrupt affinity to be changed
> 
> Marc,
> 
> I already applied v5 [1].  Can these change become an incremental patch?

Ah, my bad, I should have thought of that.

I'll send this as a couple of patches your way.

Sorry for the noise,

	M.
-- 
Jazz is not dead. It just smells funny...
