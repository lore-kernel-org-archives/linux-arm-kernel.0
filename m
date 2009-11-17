From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 17 Nov 2009 06:12:52 -0600
Subject: [PATCH] arm pxa: remove "direction input" forcing for IRQ GPIOs
In-Reply-To: <20091117120501.GC8008@gundam.enneenne.com>
References: <1258456906-12338-1-git-send-email-giometti@linux.it>
	<20091117114429.GT14091@buzzloop.caiaq.de>
	<20091117120501.GC8008@gundam.enneenne.com>
Message-ID: <f17812d70911170412t67fa6b96o607ca06d3f6b0226@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 6:05 AM, Rodolfo Giometti <giometti@enneenne.com> wrote:
> On Tue, Nov 17, 2009 at 12:44:29PM +0100, Daniel Mack wrote:
>> On Tue, Nov 17, 2009 at 12:21:46PM +0100, Rodolfo Giometti wrote:
>> > PXA CPUs may use their GPIOs as IRQ lines even if they are selected as
>> > outputs (see for example figure 24-1 into PXA27x Processor Family
>> > Developer's Manual). So forcing GPIOs IRQ lines as inputs is not
>> > correct.
>> >
>> > Programmers should set up GPIOs direction according to their usage and
>> > the function pxa_gpio_irq_type() should simply enable the IRQ
>> > detection.
>>
>> Interesting. Is this an academic issue or do you actually use that?
>> That would mean you externally drive the IO pin level to something else
>> than the output driver provides, which isn't healthy at all.
>
> It's a real configuration with no electrical drawbacks at all! Of
> course the driver's output must be passive (I use it to detect a CARD
> insert) but it's functional.

Well, that might be possible configuration but as long as there is no
real issue with this, I'd prefer the safe guard here remain intact atm.
