From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 29 Jul 2013 22:35:03 -0600
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <20130730032926.GL29970@voom.fritz.box>
References: <51F39FD8.6080808@broadcom.com> <2460092.aLmjrOVh1g@flatron>
 <51F3A82E.2000907@broadcom.com>
 <CACxGe6t0C7PTiDDaFkgoMZWUpBVokasxwZpV6HEtf3LaPi4qUw@mail.gmail.com>
 <CAKON4OymA55w_V=oP4BL2su84m8EnPgdhnQtyLWKaAJE-yNBkQ@mail.gmail.com>
 <CACxGe6uE6jOE-vz0onW5h93Es-soGiBAcFBM7Dvxh+HvCNrHkw@mail.gmail.com>
 <CACxGe6vw9=y5a+EgF1gO39SwGAdGofD2MYjyJ3jYu6uN3ke70A@mail.gmail.com>
 <1374988276.1973.29.camel@dabdike> <20130730014453.GJ29970@voom.fritz.box>
 <CAKON4OyWuF+qm2MAhbXnGg=ozzw37kpSWciLxyUy+QQzxoWdxQ@mail.gmail.com>
 <20130730032926.GL29970@voom.fritz.box>
Message-ID: <CACxGe6sUFmLZMT+dvCbpmPrzR3DNMjw64LbD3n=JsjXsmrM-qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 1:31 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sun, Jul 28, 2013 at 03:19:03PM +0200, Richard Cochran wrote:
>> On Sun, Jul 28, 2013 at 11:12:53AM +0200, Tomasz Figa wrote:
>>
>> > I'm not really sure what effect on users this has. Maybe you should define
>> > "users".
>>
>> ...
>>
>> > Care to explain this reasoning?
>>
>> Use Case
>> ~~~~~~~~
>>
>> User acquires a machine running ARM Linux version 3.x, with u-boot
>> and dtb in a read only flash partition. The board boots and works just
>> fine. However, for his application, the user requires a new kernel
>> feature that appeared in version 3.y where y > x. He compiles the new
>> kernel, and it also works.
>
> I'm afraid this kind of use case will never be properly supported, DT
> stable ABI or not.

Why? New kernel features should be no problem at all.

New driver features /might/ not be available, but only if the new
feature requires additional data that isn't present in the tree and
cannot be obtained elsewhere.

>
> Think about this: what kernel will actually be shipped in that board?
> Most likely, it will be a BSP kernel from the vendor. Does the vendor
> will have made that commitment to have a stable ABI for the DT? Will it
> use the same bindings than mainline? Do we want to support all the crazy
> bindings every vendor will come up with?

That's not a DT issue. That an out-of-tree board/SoC support issue. DT
doesn't make that any better or worse.

g.
