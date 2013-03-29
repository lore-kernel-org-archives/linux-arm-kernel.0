From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 29 Mar 2013 15:13:21 -0300
Subject: [PATCH] ARM: mvebu: Add gpio button to Mirabox board
In-Reply-To: <CABx3TkXBK6H-TT3F0P7H6o=nfqDsJ1PXjMsMzECET_-cS=vkZQ@mail.gmail.com>
References: <CABx3TkVyVAzEJ54FV70fK3BoULKCOkgNcw32_K3XT-oCUWjEfg@mail.gmail.com>
 <20130328033807.GA12212@localhost>
 <CABx3TkW0P7spbUr5gTRQMz9mqNZeWXQn8z212V1wiOPv135M7w@mail.gmail.com>
 <20130329165021.GA17433@localhost>
 <CABx3TkXBK6H-TT3F0P7H6o=nfqDsJ1PXjMsMzECET_-cS=vkZQ@mail.gmail.com>
Message-ID: <20130329181319.GA2451@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 10:30:14AM -0700, Ryan Press wrote:
> On Fri, Mar 29, 2013 at 9:50 AM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > On Thu, Mar 28, 2013 at 09:13:48PM -0700, Ryan Press wrote:
> >> On Wed, Mar 27, 2013 at 8:38 PM, Ezequiel Garcia
> >> <ezequiel.garcia@free-electrons.com> wrote:
> >> > On Wed, Mar 27, 2013 at 05:42:36PM -0700, Ryan Press wrote:
> >> >> Ezequiel Garcia wrote:
> >> >> >
> >> >> >The Globalscale Mirabox board has a little gpio button
> >> >> >placed just above the SD card slot; the board user guide labels
> >> >> >this button as "System reset button".
> >> >> >
> >> >> >This patch adds support for this button in the device tree file.
> >> >> I was not able to get this to work, I think there is
> >> >> some IRQ problem.  I was able to get it to work with
> >> >> "gpio-keys-polled" however.
> >> >>
> >> >
> >> > Could you explain what you did and what was your problem?
> >>
> >> Just to be on the same page, I pulled the latest 3-9-rc4, with no
> >> other changes, and then added your patch.  Does this rely on a patch?
> >> No interrupt events are shown in /proc/interrupts.  I have a lot more
> >> things running than your box, maybe there is a conflict.
> >>
> >
> > Try disabling SMP in your config.
> 
> Yes, that worked, thanks!  I used mvebu_defconfig initially, and this
> has CONFIG_SMP.  That's more for the Armada-XP I guess as for the
> Armada-370 it's not needed.
> 

Great.

> So I guess that means that there's something wrong with the GPIO IRQs
> with SMP.  Anyway it doesn't matter for the 370.
> 

Indeed, it doesn't matter if you plan to use your kernel only in a A370
SoC based product (A370 is single core). However, I'm afraid this could
be a problem if you plan to use the same kernel on A370 *and* AXP
(multi core) SoCs.

Next week, we'll try to debug this issue (I've added Thomas, Gregory
and Lior in Cc who might have better understanding about this).

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
