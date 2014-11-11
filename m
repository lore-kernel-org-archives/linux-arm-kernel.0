From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Nov 2014 13:29:36 +0100
Subject: [PATCH 2/7] pinctrl: pinconf-generic: Infer map type from DT
 property
In-Reply-To: <21124316.ibhe1N9UZS@avalon>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-3-git-send-email-soren.brinkmann@xilinx.com>
 <21124316.ibhe1N9UZS@avalon>
Message-ID: <CACRpkdZH9b_KB9Mz8r5vj=KGqr0bJeKMRgODUbNeBDVNr=tsCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 5, 2014 at 2:56 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 03 November 2014 11:05:26 Soren Brinkmann wrote:
>> With the new 'groups' property, the DT parser can infer the map type
>> from the fact whether 'pins' or 'groups' is used to specify the pin
>> group to work on.
>> To maintain backwards compatibitliy with current usage of the DT
>> binding, this is only done when an invalid map type is passed to the
>> parsing function.
>
> The Renesas PFC implements similar bindings with using the vendor-specific
> properties "renesas,pins" and "renesas,groups" (bindings and implementation
> available at Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> and drivers/pinctrl/sh-pfc/pinctrl.c respectively).
>
> The Renesas implementation is a bit more generic in that it allows both pins
> and groups to be specified in a single subnode. Do you think that feature
> would make sense for pinconf-generic as well ?

I think for generic pin controllers either nodes with:

{
    function = "foo";
    pins = "A0", "A1", "A2";
}

or

{
    function = "foo";
    groups = "bar", "baz";
}

In parsing this it's easy to just look for "function" then see if
we're mapping to groups or pins.

It'd be nice if we could then centralize parsing of functions/pins/groups
and add the non-renesas-prefixed configs as alternatives to genericized
the bindings, while keeping backward compatibility.

Yours,
Linus Walleij
