From: andreiw@motorola.com (Andrei Warkentin)
Date: Fri, 25 Feb 2011 05:02:18 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102241024.01437.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102231709.05036.arnd@arndb.de>
	<AANLkTimZDDo0xa2CzgHhH1LSWJ-KT0QgOmEAKs2nJK8x@mail.gmail.com>
	<201102241024.01437.arnd@arndb.de>
Message-ID: <AANLkTikWKk0kE=Hh4gfA6Mwt+-65TVFnBcOYy_eRuQfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 24, 2011 at 3:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Unlike the sysfs interface, the code does not need to be future-proof,
> it can always be changed if we feel the code becomes more maintainable
> by doing it another way.
>
> The approach that I'd like to see here is:
>
> * Start out with an ad-hoc patch for a quirk (like the one you already
> ?have).
> * Add a boolean variable to enable it per card.
> * Get performance data for this quirk to show that it's useful in
> ?real-world workloads for some cards but counterproductive for others
> * Get the patch into the mmc tree.
> * Repeat for the next quirk
> * When the code becomes overly complicated after adding all the quirks,
> ?decide on a good strategy to move the code around, and do a new patch.
>

Yup. I understand :-).  That's the strategy I'm going to follow. For
page_size-alignment/splitting I'm looking at the block layer now. Is
that the right approach or should I still submit a (cleaned up) patch
to mmc/card/block.c for that performance improvement? The other
(Toshiba quirk) is obviously a quirk belonging to mmc/card/block.c.

> I understand that you are convinced that you will need the indirect function
> calls in the end. That is fine, just don't add them before they are
> actually needed -- that would only make it harder for you to get the first
> patch included.
>
> Note that the situation is very different for user interfaces such as sysfs:
> You need to plan ahead because once the interface is merged upstream, it
> can never be changed. When you submit a patch that introduces a new sysfs
> interface, it has to be documented, and you have to convince the reviewers
> that it is sufficient to cover all the cases it is designed for, while
> at the same time it is the most simple way to achieve this.


Ok, thanks a lot for the explanation, I hadn't thought of it that way
(and should have).

A
