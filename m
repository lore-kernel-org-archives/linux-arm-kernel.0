From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Jun 2013 09:47:24 +0200
Subject: [RFC PATCH 01/11] dma: amba-pl08x: Use bitmap to pass variant
 specific quirks
In-Reply-To: <12368941.dQe8bcScGj@flatron>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-2-git-send-email-tomasz.figa@gmail.com>
 <20130617184856.GN2718@n2100.arm.linux.org.uk>
 <12368941.dQe8bcScGj@flatron>
Message-ID: <CACRpkdbt4fAdnDKuP8bVpwrWoJ-oGNuSbiDZDz5J12ix2qijfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 8:56 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Monday 17 of June 2013 19:48:56 Russell King - ARM Linux wrote:
>> On Sun, Jun 16, 2013 at 10:54:08PM +0200, Tomasz Figa wrote:
>> > Instead of defining new bool field in vendor_data struct for each
>> > quirk, it is more reasonable to use a single flags field and make
>> > each quirk use single bits.
>>
>> Please explain why this is better over the existing system, and why it
>> is not just churn for code modification's sake.
>
> It isn't anything important. I just thought that this is a better solution
> to store more than just two flags. Initially I had more of them added in
> further patches, but final version ended with just one, so this can be
> dropped.

I thought about it yesterday and it basically looks to me that
it tries to outsmart the compiler on how to stuff the flags to save
struct space on the heap and hint that they can be determined
quickly by a & operation, this is like premature optimization.

So please go back to the old system.

Yours,
Linus Walleij
