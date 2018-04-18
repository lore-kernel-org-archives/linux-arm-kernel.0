From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Apr 2018 12:50:10 +0100
Subject: [PATCH 1/2 v2] drm/pl111: Support the Versatile Express
In-Reply-To: <CACRpkdYPwm=2jhompecL5z_qwhe9UzZHKLKZLYgDK+YV_ZfMag@mail.gmail.com>
References: <20180406141935.6801-1-linus.walleij@linaro.org>
 <20180410095737.GF10254@e110455-lin.cambridge.arm.com>
 <CACRpkdb1toYJEaHDZ2QORt+qzN7imH9ugx3xvi1HASoZU0QSiQ@mail.gmail.com>
 <297aae18-8efc-b7cc-20c2-eb09d72d2dd1@arm.com>
 <CACRpkdYPwm=2jhompecL5z_qwhe9UzZHKLKZLYgDK+YV_ZfMag@mail.gmail.com>
Message-ID: <fa2dd630-6c9a-82d0-346c-1fa9530a71da@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/18 20:31, Linus Walleij wrote:
> On Tue, Apr 17, 2018 at 3:12 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 17/04/18 13:32, Linus Walleij wrote:
>> [...]
>>>
>>> Unfortunately there is just one single vexpress core tile in the
>>> upstream kernel that define a CLCD controller, the CA9 (4xA9)
>>> that I am using. All the others just use the MB CLCD.
>>>
>>> I am thinking there is some never finished DTS upstreaming
>>> here that ought to happen so we use the core tile CLCD on some
>>> other boards as well.
>>
>>
>> Barring custom FPGA images, I think V2P-CA9 *is* the only VExpress tile
>> implementing PL11x; all the more recent test chips had HDLCD instead.
> 
> Yup it looks like that.
> 
> I am restructuring the code to look for any graphics on the
> core tile and only turn on the motherboard CLCD if there is
> no CLCD or HDLCD on the core tile, e.g. if that device node has
> been set to "disabled" or the HDLCD driver is not compiled in
> but the CLCD driver is.
> 
> I found some vague mentions of a LCD display that can be
> connected to the motherboard, so that would then be sitting
> on the CLCD, is this something you ARM guys have seen
> around? In that case I guess the VExpress (etc) would actually
> be able to have two screens, one LCD panel on the motherboard
> CLCD and a DVI from the core tile.

I don't see anything in the V2M motherboard manual to suggest the IOFPGA 
CLCD output is routed anywhere other than the DVI mux, and there are 
certainly no unaccounted-for connectors on the VExpress version 
currently in front of me (HBI-0190D). The only things I'm immediately 
aware of having a panel connector directly on the board are 
Integrator/CP and RealView EB.

Robin.
