From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jan 2017 15:41:10 +0100
Subject: [PATCH v2 9/9] ARM: sunxi: Convert pinctrl nodes to generic
 bindings
In-Reply-To: <20170109111630.pcsjmc5l4v7vi2rm@lukather>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <e32d044d2d967f24f12d83eea50e7f14f2ae1073.1476200742.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67_4iriM2WS33hUWzNZY8R2WvGjqzntGBPGmNkr1Ryr_w@mail.gmail.com>
 <58723369-50ad-1792-9be1-c277eb719044@arm.com>
 <20170105153556.pzec5jjuz7pmvsmn@lukather>
 <dfd7242d-6b16-6091-979f-0bff85a20806@arm.com>
 <20170109111630.pcsjmc5l4v7vi2rm@lukather>
Message-ID: <CACRpkdYNjQaVFLDQWDFSWrtACi4+gkK9n4JEWSfpwkzW0G_Erw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2017 at 12:16 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Jan 06, 2017 at 01:17:21AM +0000, Andr? Przywara wrote:
>> > On Wed, Jan 04, 2017 at 02:16:23AM +0000, Andr? Przywara wrote:
>> >> So can I ask that we start taking this seriously and stop doing things
>> >> which prevent Allwinner boards from being supported properly?
>> >> Which would first involve dropping this very patch?
>> >
>> > The driver still supports the old binding.
>>
>> Yes, a _current_ version of the driver supports both bindings, but older
>> versions *require* the older binding and bail out if various
>> allwinner,xxx properties are missing - as in those proposed new DTs:
>>
>> 4.9 kernel with sunxi/for-next .dtb:
>> sun8i-h3-pinctrl 1c20800.pinctrl: missing allwinner,function property in
>> node uart0
>> sun8i-h3-pinctrl 1c20800.pinctrl: missing allwinner,function property in
>> node mmc0
>> sunxi-mmc: probe of 1c0f000.mmc failed with error -22
>
> This is seriously getting out of control. We already come to great
> length (and sometimes a painful amount of hacks) to satisfy a few
> individuals with a theorical interest in backward compatibility (and
> apparently, we're even the only one doing so, even more platforms
> choosing to not support that as we speak), there's seriously no reason
> to support forward compatibility as well. This has *never* been a
> thing, never has been documented nor advertised, I don't know why it
> should be one more thing to carry on our shoulders.

I agree.

We have too much standardization burden to maintain already as it is.

And AFAICT the Allwinner support is a hacker/community/enthusiast
effort without vendor backing.

We should be aware that the strong push toward DT standardization
was due to mess in the vendor trees, and as for the ambition to ship
DTBs with products, that is for people producing products to do,
not for the community. Community support can very well use attached
DTB files on the kernel from my point of view, I don't see why
ArchLinuxARM and others should have to standardize and support
DTB file in flash images, very ambitious if they do but definately
not their problem.

Yours,
Linus Walleij
