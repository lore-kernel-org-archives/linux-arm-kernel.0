From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Mar 2016 11:52:08 +0100
Subject: [PATCH v3 01/13] pinctrl: sunxi: Add A83T R_PIO controller support
In-Reply-To: <CAEzqOZta65UBJPBrp_4xr=SzHU98dWDucwzVb80eKE9ChJ8jpQ@mail.gmail.com>
References: <1457192586-25596-1-git-send-email-vishnupatekar0510@gmail.com>
 <1457192586-25596-2-git-send-email-vishnupatekar0510@gmail.com>
 <CACRpkdZ5o=SKtHxshaedkYNETERt6DfiOPtC5JV2LNWKL_mqDg@mail.gmail.com>
 <CAEzqOZta65UBJPBrp_4xr=SzHU98dWDucwzVb80eKE9ChJ8jpQ@mail.gmail.com>
Message-ID: <20160314105208.GM8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Mar 12, 2016 at 12:48:02PM +0800, Vishnu Patekar wrote:
> Hello Linus,
> 
> 
> On Wed, Mar 9, 2016 at 10:55 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Sat, Mar 5, 2016 at 10:42 PM, Vishnu Patekar
> > <vishnupatekar0510@gmail.com> wrote:
> >
> >> The A83T has R_PIO pin controller, it's same as A23, execpt A83T
> >> interrupt bit is 6th and A83T has one extra pin PL12.
> >>
> >> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> >> Acked-by: Chen-Yu Tsai <wens@csie.org>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >
> > As partly noted by others:
> >
> >> +config PINCTRL_SUN8I_A83T_R
> >> +       def_bool MACH_SUN8I
> >
> > bool
> >
> >> +       depends on RESET_CONTROLLER
> >
> > Should it rather select RESET_CONTROLLER?
> I used depends on and def_bool as it is used for other sunxi pinctrl drivers.
> Using bool and select will not harm anything.

It will, at least in the case of def_bool, since that symbol will not
be enabled by default, and you'll have no way to enable it.

And RESET_CONTROLLER is a bit messy, since you can't just select it
because it also has a dependency on an ARCH_HAS_RESET_CONTROLLER
symbol.

> Should I change it to bool and select ?  or keep it to be uniform with
> earlier options?

Please keep it that way.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160314/285c8e0c/attachment.sig>
