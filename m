From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 22 Oct 2012 13:48:37 -0500
Subject: OMAP baseline test results for v3.7-rc2
In-Reply-To: <alpine.DEB.2.00.1210221829270.13464@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
 <50857444.9080308@ti.com>
 <alpine.DEB.2.00.1210221829270.13464@utopia.booyaka.com>
Message-ID: <50859505.5010306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/22/2012 01:35 PM, Paul Walmsley wrote:
> (including the lists in my reply this time, oops; also adding some more 
> detail)
> 
> On Mon, 22 Oct 2012, Jon Hunter wrote:
> 
>> On 10/20/2012 04:26 PM, Paul Walmsley wrote:
>>
>>> Failing tests: fixed by posted patches
>>> --------------------------------------
>>>
>>> Boot tests:
>>>
>>> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>>>   - due to a GPMC bug
>>>   - Apparently fixed by http://www.spinics.net/lists/arm-kernel/msg200787.html
>>
>> This is now addressed and I have verified it is booting on v3.7-rc2. The
>> following patch address this boot problem ...
>>
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8119024ef7363591fd958ec89ebfaee7c18209e3
> 
> Great, thanks, will update the README.  Did you also enable 
> CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT, or were you able 
> to pass the DTB from the bootloader?

Actually, I built u-boot release 2012.10 for the am335x-evm and that
worked for the bone board too. So that is what I used. I have not
checked with Vaibhav and team if that is what they are using. So with
this u-boot I just passed the dtb to the kernel and did not append.

Cheers
Jon
