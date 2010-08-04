From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 4 Aug 2010 14:52:46 -0700
Subject: [PATCH 2/2] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTi=bkp+JJYQ7dF36Up3gcjJR8LypgfKBWZHLfPH-@mail.gmail.com>
References: <1277811391-17966-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=jStVGbJC7jUyhOG3og14F58rw+LEN2UqnP-X0@mail.gmail.com>
	<AANLkTi=bkp+JJYQ7dF36Up3gcjJR8LypgfKBWZHLfPH-@mail.gmail.com>
Message-ID: <AANLkTimPAeupEKwksBKOyWX8K+wHgmgc5vEJ8cXBsQtD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 4:12 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/7/28 Dan Williams <dan.j.williams@intel.com>:
>>> + ? ? ? txd = kzalloc(sizeof(struct pl08x_txd), GFP_KERNEL);
>>
>> ...appears in the prep routines. ?Will this driver be used by any
>> storage controllers on the platfom? ?Might we deadlock waiting on i/o
>> that needs to allocate a descriptor to complete?
>
> I haven't noticed anything but a descriptor pool is on my
> list of things to look into and fix.

If there is a list of things to fix and no acked-by's from anyone on
the cc list I assume you want to wait for 2.6.37??  I'm sending the
dmaengine/async_tx pull request this Friday.

--
Dan
