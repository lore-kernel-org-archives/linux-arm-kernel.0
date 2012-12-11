From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 11 Dec 2012 10:59:27 +0100 (CET)
Subject: question about drivers/pinctrl/pinctrl-at91.c
In-Reply-To: <CACRpkdb-yzpg2SJ--ksjM8TDu1cuCxMCn1cHj9OPQQt7DsjHeQ@mail.gmail.com>
References: <alpine.DEB.2.02.1212081643590.1984@hadrien>
 <CACRpkdY_znNHckam+PsysddCib2PP-6Lk4OM8_v34BX+p4pu-A@mail.gmail.com>
 <alpine.DEB.2.02.1212110958110.2091@hadrien>
 <CACRpkdb-yzpg2SJ--ksjM8TDu1cuCxMCn1cHj9OPQQt7DsjHeQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1212111059090.2091@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Dec 2012, Linus Walleij wrote:

> On Tue, Dec 11, 2012 at 10:04 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > On Tue, 11 Dec 2012, Linus Walleij wrote:
>
> >> I was under the impression that if you exit the probe function
> >> with a negative value anything allocated with devm_* was freed
> >> immediately, that is atleast how it's described in
> >> Documentation/driver-model/devres.txt
> >> atleast that seems to be the intetion with the whole thing.
> >
> > That is true, but I wasn't sure taht this function was part of the probe
> > function.  Its only reference is in:
> >
> > static struct pinctrl_ops at91_pctrl_ops = {
> >         .get_groups_count       = at91_get_groups_count,
> >         .get_group_name         = at91_get_group_name,
> >         .get_group_pins         = at91_get_group_pins,
> >         .pin_dbg_show           = at91_pin_dbg_show,
> >         .dt_node_to_map         = at91_dt_node_to_map,
> >         .dt_free_map            = at91_dt_free_map,
> > };
> >
> > Working backwards, one possible call site is pinctrl_get, which is an
> > exported function.  Is it safe to assume that it will always be called
> > from within a probe function?
>
> Aha sorry I got it all backwards :-(
>
> Well, yes in that case it's devm_kfree() for sure.

I've sent a patch, thanks.

julia
