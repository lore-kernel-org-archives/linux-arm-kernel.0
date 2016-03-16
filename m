From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 16 Mar 2016 05:36:29 +0100
Subject: [PATCH V2 2/3] vfio, platform: make reset driver a requirement
In-Reply-To: <56E5A271.6000408@codeaurora.org>
References: <1457715275-11925-1-git-send-email-okaya@codeaurora.org>
 <1457715275-11925-3-git-send-email-okaya@codeaurora.org>
 <56E5A271.6000408@codeaurora.org>
Message-ID: <56E8E2CD.3020604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,
On 03/13/2016 06:25 PM, Sinan Kaya wrote:
> On 3/11/2016 11:54 AM, Sinan Kaya wrote:
>> The code was allowing platform devices to be used without a supporting VFIO
>> reset driver. The hardware can be left in some inconsistent state after a
>> guest machine abort.
>>
>> The reset driver will put the hardware back to safe state and disable
>> interrupts before returning the control back to the host machine.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/vfio/platform/vfio_platform_common.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
> I was looking at the code. It looks like this is going to break VFIO AMBA. The
> common implementation is shared with AMBA and platform devices.
> 
> I couldn't see a reset function for AMBA devices.
> 
> Is there anyway to write reset function for it? I have no experience with 
> AMBA devices.
To my knowledge only the PL330 DMA controller (drivers/dma/pl330.c) was
passthrough'ed at some point, rather for development purpose than
production purpose. This was done by Virtual Open Systems (ask Baptiste
for more details). But I don't think this is really used.
> 
> Would you include a reset needed flag and just not require it for AMBA? 
> (I honestly don't like this idea)
> 
I think the requirement also makes sense for AMBA.

Maybe an option would be to add a module parameter that would allow to
use the vfio platform/amba driver without reset module (with explicit
opt-in from the user). Maybe this can be done later on.

FYI I will not have access to my mailbox until the end of the week.

Best Regards

Eric
