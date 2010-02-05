From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 5 Feb 2010 01:50:19 -0800
Subject: [RFC PATCH 3/3] [ARM] Allow boards to specify the exact number of
	IRQs needed
In-Reply-To: <20100205083050.GG13267@trinity.fluff.org>
References: <f17812d71002041112x6f8308b5q6bc37f6608a3efc9@mail.gmail.com>
	<20100205083050.GG13267@trinity.fluff.org>
Message-ID: <f17812d71002050150w4b4d463fj20a39b406aed3cb6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2010 at 12:30 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Thu, Feb 04, 2010 at 11:12:37AM -0800, Eric Miao wrote:
>> commit 988a6a2bd322d83eba42c05cb6cb77a74cba056b
>> Author: Eric Miao <eric.y.miao@gmail.com>
>> Date: ? Thu Feb 4 11:06:35 2010 -0800
>>
>> ? ? [ARM] Allow boards to specify the exact number of IRQs needed
>>
>> ? ? This will only take effect if SPARSE_IRQ is enabled, any board that
>> ? ? depends on this _only_ has to explicitly select SPARSE_IRQ.
>>
>> ? ? Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>
> out of interest, what happens if the user wants to instantiate an irq
> that is above the board's nr_irq setting?
>

Normally, he doesn't. Well, the board's nr_irq should have included
all the possible IRQs used on that specific board.

Taking into account of expansion at run-time (e.g. insertion into a
baseboard dynamically), he's still able to do that with

irq_to_desc_alloc_node()

instead of irq_to_desc()

explicitly when adding elements to irq_desc[].
