From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 23 Sep 2010 08:35:13 -0700
Subject: [PATCH 11/12] DMAENGINE: let PL08X memcpy TXDs wait
In-Reply-To: <AANLkTi=7gsXT2P-7a=DCTsaUBK=B131VFFCBzNVzpYFv@mail.gmail.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-6-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-7-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-8-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-9-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-10-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-11-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-12-git-send-email-linus.walleij@stericsson.com>
	<AANLkTimGu1R0vqpLK9X30CxkibO6N964D1Y-fQvAdA9D@mail.gmail.com>
	<AANLkTi=7gsXT2P-7a=DCTsaUBK=B131VFFCBzNVzpYFv@mail.gmail.com>
Message-ID: <AANLkTik0Qy9nbWcreL3oOYg-KKhZ793i6tvfCmwiLgc=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 12:46 AM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/9/23 Dan Williams <dan.j.williams@intel.com>:
>
>> The prep routine is meant to guarantee that all the resources for a
>> transaction have been acquired.
>
> A practicality here:
>
> The assumption to fail for physical channel allocation at .tx_submit()
> is already in the first patch adding the driver.
>
> Should I squash all the icremental improvements into the original
> driver, convert to fail at .prep() and resubmit to make all of this
> easier, or do you want me to refactor the patch stack, or refactor
> from patch 11/12 or...?
>

At this point I am already rebasing my next branch to catch up with
the backlog, so a new v5 of the driver with all the roll-ups works for
me.

Also not sure if you caught this comment from earlier:
> sidenote: this driver needs to be converted to a dma descriptor pool
> (allocated at device_alloc_chan_resources time), or at a minimum use
> GFP_NOWAIT in device_prep_dma_memcpy because that routine may be
> called from atomic contexts.

Thanks,
Dan
