From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Feb 2014 07:27:36 -0600
Subject: [PATCH 02/18] arm64: GICv3 device tree binding documentation
In-Reply-To: <52FCC1C2.1020203@arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-3-git-send-email-marc.zyngier@arm.com>
 <loom.20140207T062553-254@post.gmane.org>
 <52FCC1C2.1020203@arm.com>
Message-ID: <CAL_Jsq+i66=EuWqSHuVWmH21S-KM5fckNz5-xBxW74ySnUKRWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 6:59 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Arnab,
>
> On 07/02/14 05:41, Arnab Basu wrote:
>> Hi Marc
>>
>> Marc Zyngier <marc.zyngier <at> arm.com> writes:
>>
>>> +
>>> +AArch64 SMP cores are often associated with a GICv3, providing private
>>> +peripheral interrupts (PPI), shared peripheral interrupts (SPI),
>>> +software generated interrupts (SGI), and locality-specific peripheral
>>> +Interrupts (LPI).
>>> +
>>> +Main node required properties:
>>> +
>>> +- compatible : should at least contain  "arm,gic-v3".
>>> +- interrupt-controller : Identifies the node as an interrupt controller
>>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>>> +  interrupt source. Must be a single cell with a value of at least 3.
>>> +
>>> +  The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
>>> +  interrupts. Other values are reserved for future use.
>>
>> These values are defined in
>> "include/dt-bindings/interrupt-controller/arm-gic.h" maybe we should start
>> mentioning that here and encourage future device treese to use those defines
>> to improve readability.
>
> It may improve readability, but it makes the definition rely on
> something else. Definition and usage are two different things, and I
> want the definition to be completely self-contained and non ambiguous.
>
> In DTS files, people can use whatever macro they decide, and it is their
> problem. They will even have out of tree DTS files, for which the
> include file is not available.

Agreed.

Rob
