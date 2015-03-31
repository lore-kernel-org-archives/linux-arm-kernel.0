From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 31 Mar 2015 12:47:12 -0500
Subject: [RESEND] Altera socfpga big endian work
In-Reply-To: <551ABE7D.4090908@codethink.co.uk>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
 <551AAB9D.1000809@opensource.altera.com> <551ABE7D.4090908@codethink.co.uk>
Message-ID: <551ADDA0.5010500@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/31/15 10:34 AM, Ben Dooks wrote:
> On 31/03/15 15:13, Dinh Nguyen wrote:
>> Hi Ben,
>>
>> On 3/25/15 6:27 AM, Ben Dooks wrote:
>>> This series enables the core of the socfpga systen to run in big endian
>>> mode. It inclusdes support for debug uart, secondary core boot and has
>>> support for timers and initial conversion patches for the mmc.
>>>
>>> The two drivers that are known to not work are the Ethernet and the
>>> dwc2 usb. I do not have data for either, so I currently do not know
>>> if it possible to change the hardware's endian fetch mode.
>>>
>>> The dwc2 driver on my cyclone5 socfpga board with v4.0-rc5 does not
>>> work in little endian mode, which makes testing converting the driver
>>> difficult. The supplied 3.10 kernel does work so it is not down to the
>>> hardware. It detects the presence of a new device and then fails to
>>> enumerate it (no other errors shown)
>>>
>>> This is up on git.baserock.org/delta/linux.git in the branch
>>> baserock/bjdooks/socfpga-v5
>>>
>>> Sorry, this is a resend due to incorrect linux-arm-kernel mailing list
>>> address.
>>>
>>
>> I think I can take patches 1-3 through my tree, but the mmc patches
>> [4-7] will need to linux-mmc tree.
> 
> Thanks. I did CC 4-7 to the relevant maintainers.
> 
> Any idea if dwc2 is going to be fixed before 4.1?
> 
> 

I'll have to double check again, but I thought dwc2 on the socfpga has
been work fine for quite some time now. What are the errors that you are
seeing?

Dinh
