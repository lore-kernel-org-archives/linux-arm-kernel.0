From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 15 Aug 2013 19:41:46 +0200
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <20130815155652.GB14792@kroah.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CABb+yY1YKGkAeb-8GbadUoV5g54iCdrYGnD_VSpaNmtfXXhpyA@mail.gmail.com>
 <CAGsJ_4yZ7Rf7UV-1u3cG_V9mrtCWD=LYBeuKQaz0SWLYoHhwwg@mail.gmail.com>
 <20130815080532.GB7080@kroah.com>
 <CAKv+Gu9mOxoTsK5g-GX2Khvu0FSUBZRCL0Jw6F6vrMG=fNfy1Q@mail.gmail.com>
 <20130815155652.GB14792@kroah.com>
Message-ID: <CAKv+Gu8_65EkDkn6-W1NKZSs9P8KOxfFNzFNXq0Eqm5dMYGxwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2013 17:56, Greg KH <greg@kroah.com> wrote:
>
> On Thu, Aug 15, 2013 at 10:24:41AM +0200, Ard Biesheuvel wrote:
> > On 15 August 2013 10:05, Greg KH <greg@kroah.com> wrote:
> > > On Thu, Aug 15, 2013 at 03:45:13PM +0800, Barry Song wrote:
> > >> 2013/8/15 Jassi Brar <jassisinghbrar@gmail.com>:
> > >> > On Thu, Aug 15, 2013 at 9:58 AM, Greg KH <greg@kroah.com> wrote:
> > >> >> On Thu, Aug 15, 2013 at 11:44:30AM +0800, Barry Song wrote:
> >
> > [...]]
> >
> > >> we will run rtos+linux instead of linux+linux. typically, Auto
> > >> industry has long history to use rtos. on the other hand, we need to
> > >> boot the rtos very fast in hundreds of milliseconds to make sure
> > >> rearview, early audio have been ready.
> > >
> > > But Linux is a RTOS, and a really good one at that.  Linux already boots
> > > that fast, and solves the rearview/early audio issue just fine (I've
> > > seen it demoed), so please don't think that Linux can't do this.
> > >
> > > Again, what is the requirements of this RTOS that prevent you from using
> > > Linux instead in that "secure" part of the chip?  What do we need to
> > > change in order to meet this need?
> > >
> >
> > In my experience, there are two similar yet different use cases:
> > - the desire to co-host a RTOS on the CPU next to Linux, to perform
> > real-time tasks like software defined radio, fast boot times etc.
> > - the desire to secure devices using TrustZone, without putting a full
> > fledged kernel on the secure side due to memory constraints (note that
> > in many designs, the only secure memory is the on-SoC SRAM)
> >
> > As the requirements are almost orthogonal, we should not pretend they
> > are the same thing.
>
> I'm not pretending they are the same thing, but I am wanting to know how
> Linux doesn't work for either of those requirements, as I want to see
> Linux be the solution for this "trusted" kernel as well.
>

For the former case, there is the assumption (or misconception) that
Linux cannot deliver the boot speed or bounded worst case response
time requirements imposed by things like software defined radio. Also,
there is the existing codebase of RTOS hosted CAN stacks etc, that
have been certified by the [automotive] customer and are moved from a
dedicated MCU into the application CPU as a cost saving measure. This
means that even if Linux does fit the bill in principle, many will
still have no choice other than to go with non-Linux.

For the latter case, it depends on the compatibility of Linux with the
restricted secure world environment, most notably the secure memory.
256k of on chip SRAM is sufficient to do plenty of interesting things
in the secure world, but sadly, running Linux is not one of them. (I
know PoP DDR is considered to be secure memory by some vendors as
well, but its application is not as widespread in the automotive
world)


Regards,

--
Ard.
