From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 23 Sep 2011 09:35:57 -0400
Subject: Identifying Primecells
In-Reply-To: <4E7C89FC.4090209@gmail.com>
References: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
	<4E7C7FA2.30404@gmail.com>
	<CAKON4OzGEo+XvcNg=mzp3jhq3d3m7Z9bvZTSVCNLNjZ=KYbNBQ@mail.gmail.com>
	<4E7C89FC.4090209@gmail.com>
Message-ID: <CAKON4OxZPFFL5NAgxLPRw2xxnS=v7iVWtQSSLcUJWfOYh4yfjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 9:30 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/23/2011 08:11 AM, jonsmirl at gmail.com wrote:
>> On Fri, Sep 23, 2011 at 8:46 AM, Rob Herring <robherring2@gmail.com> wrote:
>>> On 09/22/2011 01:19 PM, jonsmirl at gmail.com wrote:
>>>> I'm working on device tree support for the NXP LPC3130. To do this
>>>> right I need to know what specific Primecells were used in the chip.
>>>> How do I identify the primecell numbers for the devices? It is a
>>>> 926ejs core.
>>>>
>>>
>>> I'm not sure I understand the question.
>>>
>>> The primecell periph id numbers are only in the DT if they are wrong in
>>> the h/w for some reason. The compatible property should contain the
>>> device model number (i.e. "arm,pl011" for the uart).
>>
>> So how do I figure out which id numbers to use for the NXP LPC3130?
>> Is the UART a pl011?
>>
> The chip's documentation or ARM's documentation. The existing board
> code. Read each periph ID register.

Kernel support is out of tree, I'm trying to get it into shape for
submission. Nothing in the existing driver code mentions the
peripheral ID. I've asked NXP to identify them and they have not
responded.

Is peripheral use documented at ARM for the lpc3130? What I don't know
is if the peripherals have been modified or replaced with an
alternative implementation.

So I guess I need to figure out how to read the ID register.

>
> Or the ones with drivers in the kernel:
> find drivers -name '*pl[0-3]*'
>
> Rob
>



-- 
Jon Smirl
jonsmirl at gmail.com
