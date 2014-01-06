From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 06 Jan 2014 01:05:01 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <20140105234009.GC11280@obsidianresearch.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de> <20140105154023.GA2048@lunn.ch>
 <20140105172756.GA11280@obsidianresearch.com> <52C99851.70806@gmail.com>
 <20140105230746.GB11280@obsidianresearch.com> <52C9E6D0.3000406@gmail.com>
 <20140105234009.GC11280@obsidianresearch.com>
Message-ID: <52C9F32D.5080007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2014 12:40 AM, Jason Gunthorpe wrote:
> On Mon, Jan 06, 2014 at 12:12:16AM +0100, Sebastian Hesselbarth wrote:
>> On 01/06/2014 12:07 AM, Jason Gunthorpe wrote:
>>> On Sun, Jan 05, 2014 at 06:37:21PM +0100, Sebastian Hesselbarth wrote:
>>>
>>>> If you mean clock-gated with "powered down", the code is safe. It
>>>> enables the clock gate prior reading from the controller. Or is there
>>>> another way to power down the controller, so you cannot read from the
>>>> controller registers?
>>>
>>> There is a clock gate and a power down on kirkwood at least, Linux has
>>> no code for controlling the powerdown
>>
>> Does that power down really disable reading from PCIe controller
>> registers or is it just PHY power down?
>
> I haven't experimented with it, but every block that has a clock gate
> has a power down, so I doubt it is just a phy power down.

Ok, I see. But it isn't documented in the public FS, is it? If there is
an extra powerdown register for each ip block, I guess it will also
break reading from its registers.

>>> In any event, I think processing a disabled DT node is not great..
>>
>> Yeah, but you see another way to get the PCIe controller registers
>> instead? Or any other common id register to read? IMHO PCIe ids are
>> the best we can find here and Gregory found the first IP that really
>> depends on the SoC revision..
>
> I don't know of another option off hand, unless something is encoded
> in the CPU ID register set.
>
> Encoding the IP block version in the I2C DT compatible string is the
> next best choice, but it obviously isn't automatic..

True. But I still wonder how many users will find the correct dtb
without knowing the SoC revision. Having it probed would be best for
users, but I see the difficulties.

We should really work harder on proper u-boot/barebox for all those
Orion SoCs to have at least the option to update it with DT support.

Sebastian
