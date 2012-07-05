From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 05 Jul 2012 18:30:00 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <4FF5B7F9.9020507@googlemail.com> (Sebastian Hesselbarth's
 message of "Thu, 05 Jul 2012 17:51:21 +0200")
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <20120705130819.GV17534@lunn.ch> <4FF5A15A.8070309@googlemail.com>
 <201207051454.24475.arnd@arndb.de> <4FF5B7F9.9020507@googlemail.com>
Message-ID: <87hatmi31z.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com> writes:

> On 07/05/2012 04:54 PM, Arnd Bergmann wrote:
>> This way you have multiple nodes with the same register
>> and different names, which is not how it normally works.
>
> Ok.
>
>>> This would have the advantage that DT describes gpio-to-irq dependencies.
>>> Moreover, nodes that reference gpios can do gpios =<&gpio 71 0>; instead of
>>> gpios =<&gpio3 7 0>;
>>
>> Is that desired?
>>
>> The device tree representation should match what is in the data sheet
>> normally. If they are in a single continuous number range, then we should
>> probably have a single device node with multiple register ranges
>> rather than one device node for each 32-bit register. Looking at
>> arch/arm/plat-orion/gpio.c I think that is not actually the case though
>> and having separate banks is more logical.
>
> Well, looking at the datasheet of Dove GPIOs are numbered [63:0] plus
> GPOs [71:64]. This dt will be a lot shorter and maybe it is describing
> the hardware as it is. (Not sure about the syntax for irqs, though)

They're numbered as [63:0] and [71:64] but they're on 3 different banks.
iirc, there may even be some differences with the way the banks are dealing
interrupts, so I don't see any reason to not represent the 3 banks in DT.

Arnaud
