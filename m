From: monstr@monstr.eu (Michal Simek)
Date: Tue, 04 Jun 2013 08:54:59 +0200
Subject: [PATCH] net/macb: fix ISR clear-on-write behavior only for some
 SoC
In-Reply-To: <20130604064940.GA5107@pengutronix.de>
References: <1368461105-23128-1-git-send-email-nicolas.ferre@atmel.com>
 <FE065E51-1EAA-47ED-8C7B-0F2E6418F349@jcrosoft.com>
 <51918C23.7040106@yahoo.es> <20130514055256.GD22508@game.jcrosoft.org>
 <51AD8611.8070102@monstr.eu> <20130604064940.GA5107@pengutronix.de>
Message-ID: <51AD8F43.4090107@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2013 08:49 AM, Steffen Trumtrar wrote:
> On Tue, Jun 04, 2013 at 08:15:45AM +0200, Michal Simek wrote:
>> On 05/14/2013 07:52 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 08:58 Tue 14 May     , Hein Tibosch wrote:
>>>> On 5/14/2013 12:05 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>> On May 14, 2013, at 12:05 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>>>>>
>>>>>> Commit 749a2b6 (net/macb: clear tx/rx completion flags in ISR)
>>>>>> introduces clear-on-write on ISR register. This behavior is not always
>>>>>> implemented when using Cadence MACB/GEM and is breaking other platforms.
>>>>>> We are using a new Device Tree compatibility string and a capability
>>>>>> property to actually activate this clear-on-write behavior on ISR.
>>>>>>
>>>>>> Reported-by: Hein Tibosch <hein_tibosch@yahoo.es>
>>>>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>>> can we detect it via the IP?
>>>>
>>>> This was my first proposal, have it based on the value of MACB's
>>>> register 'MID' (offset 0x00fc, lower 16 bits).
>>>> On avr32 it reads: 0x0000010D, on Zynq it reports 0x00000119
>>>>
>>>> So for the moment, CAPS_ISR_CLEAR_ON_WRITE could be set if the revision
>>>> equals to 0x00000119?
>>> so no it will not work
>>>
>>> as the gem on sama5 is 00020119
>>>
>>> so version 0x119 too
>>>
>>> nico 
>>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>
>> Was this added to any queue or branch?
>> I would like to enable macb for zynq and not sure if "cdns,zynq-7000-gem"
>> compatible string goes to mainline.
>>
> 
> Hi!
> 
> This is already in next, but you can use the default compatible as the
> DCR1 is used instead of DT binding.

Ah ok. It was added there without cdns,zynq-7000-gem compatible string.

BTW: I have asked Soren to update your patch on the top of his clock changes.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130604/ab3c08fb/attachment.sig>
