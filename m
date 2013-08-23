From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 15:45:52 +0100
Subject: [PATCH 26/33] ARM: ux500: Remove AUXDATA relating to SDI (MMC)
 clock-name bindings
In-Reply-To: <CACRpkdb+WEecBEuFtoDLv9k3vyi=o0nZcLfCeny-7+uxdNBryA@mail.gmail.com>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-27-git-send-email-lee.jones@linaro.org>
 <CACRpkdb+WEecBEuFtoDLv9k3vyi=o0nZcLfCeny-7+uxdNBryA@mail.gmail.com>
Message-ID: <20130823144552.GC19107@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Aug 2013, Linus Walleij wrote:

> On Thu, Jun 6, 2013 at 2:17 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> (...)
> >         /* Requires DMA bindings. */
> >         OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
> > -       OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  &mop500_sdi0_data),
> > -       OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  &mop500_sdi1_data),
> > -       OF_DEV_AUXDATA("arm,pl18x", 0x80005000, "sdi2",  &mop500_sdi2_data),
> > -       OF_DEV_AUXDATA("arm,pl18x", 0x80114000, "sdi4",  &mop500_sdi4_data),
> 
> This cannot be done. Ulf H would beat me up if I applied this.
> 
> The platform data there in the end is actually used.
> 
> Especially look at mop500_sdi0_data, it contains a lot of stuff that is
> not yet DT:ed even (a task in its own right).
> 
> But as long as we keep this pdata we can still delete ATAGs support (as
> per the second patch set pending) and get a clearer picture.

Agreed. Scrap the patch.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
