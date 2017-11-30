From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Nov 2017 16:20:52 +0100
Subject: [RFC PATCH 0/3] pinctrl: sunxi: Add DT-based generic pinctrl
 driver
In-Reply-To: <54ecfdf7-cf4a-3eae-2661-47fa668a6066@arm.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <CACRpkdYFoUmGJYdKz0t9gsrkK=u8-oJjaRBXtNYHaUt9kSa3_g@mail.gmail.com>
 <54ecfdf7-cf4a-3eae-2661-47fa668a6066@arm.com>
Message-ID: <CACRpkdZQPspH79_nS-WgiSg6d2meXUztgocYbxO07vTgP1HehA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 1:05 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> On 24/11/17 10:28, Linus Walleij wrote:

>> The DT maintainers have been pretty clear on that they don't like
>> using the the DT as a generic fit-all information dump. They
>> prefer to look up hardware data from per-soc compatible strings.
(...)
> I am just a bit worried that with Allwinner recently playing the SKU
> game we end up with tons of tables for only slightly different SoCs (see
> the H3 and H5, for instance). And with single image kernels we pile up
> quite some *data* in each kernel, which is of little interest for
> everyone else.

So what you are saying is that you want to use the DTS for
data dumping and what I'm saying is that the DT maintainers
do not like that stance.

They will have to speak on the issue directly before we continue
I think.

I have been getting a *LOT* of pushback to putting large amounts
of data and configuration in the DTS recently, so IIUC that is something
they simply don't like, probably for good reasons.

C.f:
https://www.spinics.net/lists/dri-devel/msg150321.html

> Also my understanding is that the actual Allwinner pin controller IP
> (register map) is very much the same across all SoCs. Mostly the only
> difference is the mapping between pins and mux functions, which we
> express in the DT already anyway (in the subnodes). And this is really a
> poster book example of what DT should be doing: express the specific
> mappings of a particular implementation. I don't see why this would need
> to be per-board only, if we can pull this up to the SoC level.

It's not me you need to sell this point.

You need to sell it to the DT maintainers.

Yours,
Linus Walleij
