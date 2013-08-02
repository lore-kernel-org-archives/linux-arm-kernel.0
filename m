From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 2 Aug 2013 11:18:08 -0400
Subject: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1
 CPU devices
In-Reply-To: <20130802141828.GC2361@localhost.localdomain>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
 <20130802141828.GC2361@localhost.localdomain>
Message-ID: <51FBCDB0.4070401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 August 2013 10:18 AM, Dave Martin wrote:
> On Thu, Aug 01, 2013 at 02:17:13PM -0400, Santosh Shilimkar wrote:
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> The generic code is well equipped to differentiate between
>> SMP and UP configurations.However, there are some devices which
>> use Cortex-A9 MP core IP with 1 CPU as configuration. To let
>> these SOCs to co-exist in a CONFIG_SMP=y build by leveraging
>> the SMP_ON_UP support, we need to additionally check the
>> number the cores in Cortex-A9 MPCore configuration. Without
>> such a check in place, the startup code tries to execute
>> ALT_SMP() set of instructions which lead to CPU faults.
>>
>> The issue was spotted on TI's Aegis device and this patch
>> makes now the device work with omap2plus_defconfig which
>> enables SMP by default. The change is kept limited to only
>> Cortex-A9 MPCore detection code.
> 
> Is there a specific reason why this can't happen for other processors
> such as A5/7/15?
> 
The basic reason behind limiting to A9 was the SCU carrying
the no. of CPU information is specific to A9. A7/A15 have
that information encoded in L2 control register. Since
same code won't work for the other ARM versions and we
don't wanted to pollute the code much without need of it
those versions are not considered.

Regards,
Santosh
