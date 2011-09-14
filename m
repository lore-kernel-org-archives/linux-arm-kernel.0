From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 14 Sep 2011 11:06:32 +0530
Subject: [PATCH 01/25] ARM: mm: Add strongly ordered descriptor support.
In-Reply-To: <20110913202317.GE24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-2-git-send-email-santosh.shilimkar@ti.com>
	<20110913202317.GE24252@atomide.com>
Message-ID: <CAMQu2gw6=RmmoWnRQ34RVjvSBbfvK2-3R9eFXqLZLjw_XR7Jyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 1:53 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:22]:
>> On certain architectures, there might be a need to mark certain
>> addresses with strongly ordered memory attributes to avoid ordering
>> issues at the interconnect level.
>
> This is something Russell needs to look.
>
> You might want to also read the mailing list archives regarding the
> strongly ordered access.
>
> Basically it still won't guarantee that the write gets to the
> device, only a read back from the device in question guarantees
> that at the bus level.
>
Russell has already seen this. I have sent this patches to Russell
before adding them
in the queue.

This is different. There is a BUG in asynchronous bridges on OMAP44XX
devices and
that's the reason it' s needed.

Regards
Santosh
