From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 20 Mar 2017 12:34:03 +0100
Subject: [PATCH v4 00/18] add support for AXP20X and AXP22X power supply
 drivers
In-Reply-To: <20170315224647.suhnptpczykuoffd@earth>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315121450.bl5dxdjzazwsrvni@dell>
 <bc829791-c543-220a-8c42-1023b1a82963@free-electrons.com>
 <20170315224647.suhnptpczykuoffd@earth>
Message-ID: <949439a1-2f66-bdb7-04ae-ff88cb388809@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian and Liam,

On 15/03/2017 23:46, Sebastian Reichel wrote:
> On Wed, Mar 15, 2017 at 02:18:56PM +0100, Quentin Schulz wrote:
>> Hi Lee,
>>
>> On 15/03/2017 13:14, Lee Jones wrote:
>>> On Wed, 15 Mar 2017, Quentin Schulz wrote:
>>>
>>>> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
>>>> information and data of the various power supplies they support such as
>>>> ACIN, battery and VBUS. For example, they expose the current battery
>>>> voltage, charge or discharge, as well as ACIN and VBUS current voltages
>>>> and currents, internal PMIC temperature and ADC on 2 different GPIOs
>>>> when in the right mode (for the AXP209 only).
>>>
>>> What are you missing from this set now?  What Acks etc?  And what's
>>> the plan with regards to route to Mainline?  Where are the dependencies
>>> etc?
>>>
>>
>> Basically, a consensus on how we should named the DT property I added in
>> patch 01 and 02 (which is used afterwards in battery driver). All other
>> patches have ACKs.
>>
>> I added some logic to the battery driver so if anyone wants to review
>> that you're welcome. I already got several ACKs from the v3 though.
>>
>> No dependencies except for the battery driver (and the first two
>> patches) which needs the battery "framework" in the Power Supply
>> subsystem. A v9 of this framework has been sent a little bit more than a
>> week ago, I need this to be merged first or the battery driver will just
>> not compile. I think the other patches are ready to be merged.
> 
> FWIW I expect, that the axp battery patches go through my tree, since
> there doesn't seem to be a compile time dependency to the other
> patches from this series nor vice versa. I'm aware of the dependency
> to the bq27xxx series of course.
> 

As there are still some discussion going on Liam's patch series on which
my patch series depends, I propose to wait for it to be merged and then
I'll rework these battery driver patches. Is there anything I can do to
help the merging of Liam's patch series?

Could you ping me when it is merged? The easiest way would be to Cc me
to the next version though so I can follow the discussion :)

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/3218d507/attachment.sig>
