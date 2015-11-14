From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Nov 2015 11:46:59 +0100
Subject: [PATCH 1/3] mtd: create a partition type device tree binding
In-Reply-To: <20151113220039.GA74382@google.com>
References: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
 <20151029162908.GA13275@localhost>
 <CACRpkdYS5Jf8UC2K0bNdEQZDjTeZZx44Uu-kkof+9E=4Ny0oDg@mail.gmail.com>
 <20151030175145.GF13239@google.com>
 <CAL_JsqL2F3p7qBPbOiGytVyzF_aNLWbrCT0mAX1WZo6SxE3JoA@mail.gmail.com>
 <20151113220039.GA74382@google.com>
Message-ID: <CACRpkdakyae95f_Lc-R7Uf7wndj5hyfCqqHziwmZjwm-uNkGAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 11:00 PM, Brian Norris
<computersforpeace@gmail.com> wrote:

(...)
>  (2) we should define a comptible property for the hard-coded
>  partitioning case (e.g., compatible = "partitions")
(...)
> If we went with option (2), then ofpart.c could just check only for
> 'compatible = "partitions"' (or similar), and if not found bail out.

So this "hard-coded partitioning case" the case is where all partitions
are defined in the device tree as described in
Documentation/devicetree/bindings/mtd/partition.txt ?

Or is it a way to indicate that this array
static const char * const part_probe_types_def[] = {
        "cmdlinepart", "RedBoot", "ofpart", "ofoldpart", NULL };
in physmap_of.c should be used?

Sorry if I don't fully follow, I'm a bit stupid when it comes to the MTD
helicopter  view of the situation.... :(

> I think option (2) makes more sense. But it would require an update to
> the binding and code for 4.4, since [1] was only introduced during this
> release cycle.

Does that mean all old device trees that specify no compatible
string all of a sudden stop working? We can't break the DT ABI, so I
guess not.

A bit confused here, I can't really see what I should do with the patch...

Yours,
Linus Walleij
