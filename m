From: minyard@acm.org (Corey Minyard)
Date: Thu, 15 Sep 2016 07:23:08 -0500
Subject: [PATCH 1/3] misc: Add Aspeed BT IPMI host driver
In-Reply-To: <3e2658cc-7089-abd2-23b3-ffd468edbd11@kaod.org>
References: <1472664259-23933-1-git-send-email-clg@kaod.org>
 <c06a8afb-9143-6aef-3425-ad1e50cae35d@kaod.org>
 <1ce6c4b4-5938-22fc-7467-d1efc220b772@gmail.com> <4727554.yt7pF8chOH@wuerfel>
 <7db5ada0-49ea-55eb-089e-d979941ceff5@gmail.com>
 <3e2658cc-7089-abd2-23b3-ffd468edbd11@kaod.org>
Message-ID: <c16a0c73-310b-9534-d269-4f02bd00161d@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2016 01:51 AM, C?dric Le Goater wrote:
> On 09/12/2016 10:33 PM, Corey Minyard wrote:
>> On 09/12/2016 02:15 PM, Arnd Bergmann wrote:
>>> On Monday, September 12, 2016 1:55:40 PM CEST Corey Minyard wrote:
>>>> On 09/02/2016 08:22 AM, C?dric Le Goater wrote:
>>>>> Hello,
>>>>>
>>>>> Adding Corey in cc: . I guess I should have done that in the first place.
>>>> Yes, probably so.  I've been travelling and didn't see it on the mailing
>>>> lists until now.
>>>>
>>>> There is already a BT driver in the kernel, in drivers/char/ipmi, why
>>>> won't that work?
>>> The new driver is the host side (running on the BMC), the existing one
>>> is the client (running on the PC).
>>>
>>>      Arnd
>> Ok, that's not really clear from the documentation or the Kconfig.
>> In the IPMI spec the "host" side is the computer side, not the BMC
>> side.  Like:
>>
>>     11.6.1 BT Host Interface Registers
>>     The Host BT interface provides an independent set of registers and
>>     interrupts to allow the Host driver to
>>     communicate with the baseboard management controller without
>>     conflicting with the O/S ACPI driver.
>>
>> In light of that, this should probably be named the bt-bmc driver.
>>
>> I haven't reviewed this in detail, but I'm ok with putting it in
>> drivers/char/ipmi.  The state machine part looks reasonably
>> generic.  The configuration part isn't, but that could be split
>> out later if necessary.
> what do you mean by configuration ? I am ready to send a v2. May be
> I can add a few other things.

The part that sets everything up, basically everything from
bt_host_fops down.

If you were to use this on another system, that code would have to be
made more generic and the machine-specific part split into different
files, but that's not necessary now, I don't think.

-corey

> Thanks,
>
> C.
