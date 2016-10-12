From: vigneshr@ti.com (Vignesh R)
Date: Wed, 12 Oct 2016 16:40:20 +0530
Subject: [PATCH RESEND] ARM: dts: keystone-k2*: Increase SPI Flash
 partition size for U-Boot
In-Reply-To: <d1a4b59e-5524-9851-425e-5e86e05a593c@oracle.com>
References: <20161010141141.21333-1-vigneshr@ti.com>
 <20161010143144.GB1041@n2100.armlinux.org.uk>
 <d1a4b59e-5524-9851-425e-5e86e05a593c@oracle.com>
Message-ID: <71299871-965f-aef3-7301-4d587430a1a5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 10 October 2016 09:31 PM, Santosh Shilimkar wrote:
> Vignesh,
> 
> On 10/10/2016 7:31 AM, Russell King - ARM Linux wrote:
>> On Mon, Oct 10, 2016 at 07:41:41PM +0530, Vignesh R wrote:
>>> U-Boot SPI Boot image is now more than 512KB for Keystone2 devices and
>>> cannot fit into existing partition. So, increase the SPI Flash partition
>>> for U-Boot to 1MB for all Keystone2 devices.
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>> ---
>>>
>>> This was submitted to v4.9 merge window but was never picked up:
>>> https://patchwork.kernel.org/patch/9135023/
> 
> Another point is, if you want me to pick your patch, please copy
> me next time :-). AFAIK, am seeing this patch in my inbox first time.
> 

Sorry, I did address the previous patch to you. Not sure what happened :(

>>
>> I think you need to explain why it's safe to change the layout of the
>> flash partitions like this.
>>
>> - What is this "misc" partition?
>>
>> - Why is it safe to move the "misc" partition in this way?
>>
>> - Do users need to do anything with data stored in the "misc" partition
>>   when changing kernels?
>>
>> If the "misc" partition is simply unused space on the flash device, why
>> list it in DT?
>>
> Thanks Russell. Yes, above clarification would be good to get first.


Ok, will send v2 with updated commit message as per my reply in other
thread.

-- 
Regards
Vignesh
