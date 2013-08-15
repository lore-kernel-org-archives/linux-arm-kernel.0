From: greg@kroah.com (Greg KH)
Date: Thu, 15 Aug 2013 11:26:00 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <CAKv+Gu8_65EkDkn6-W1NKZSs9P8KOxfFNzFNXq0Eqm5dMYGxwQ@mail.gmail.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CABb+yY1YKGkAeb-8GbadUoV5g54iCdrYGnD_VSpaNmtfXXhpyA@mail.gmail.com>
 <CAGsJ_4yZ7Rf7UV-1u3cG_V9mrtCWD=LYBeuKQaz0SWLYoHhwwg@mail.gmail.com>
 <20130815080532.GB7080@kroah.com>
 <CAKv+Gu9mOxoTsK5g-GX2Khvu0FSUBZRCL0Jw6F6vrMG=fNfy1Q@mail.gmail.com>
 <20130815155652.GB14792@kroah.com>
 <CAKv+Gu8_65EkDkn6-W1NKZSs9P8KOxfFNzFNXq0Eqm5dMYGxwQ@mail.gmail.com>
Message-ID: <20130815182600.GA22567@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 07:41:46PM +0200, Ard Biesheuvel wrote:
> > I'm not pretending they are the same thing, but I am wanting to know how
> > Linux doesn't work for either of those requirements, as I want to see
> > Linux be the solution for this "trusted" kernel as well.
> >
> 
> For the former case, there is the assumption (or misconception) that
> Linux cannot deliver the boot speed or bounded worst case response
> time requirements imposed by things like software defined radio.

So, what can we do to address this?  Technically I think Linux can
handle this just fine, as others have pointed out it is used in these
situations.

> Also, there is the existing codebase of RTOS hosted CAN stacks etc,
> that have been certified by the [automotive] customer and are moved
> from a dedicated MCU into the application CPU as a cost saving
> measure. This means that even if Linux does fit the bill in principle,
> many will still have no choice other than to go with non-Linux.

That's their decision, which is fine.  Getting the Linux CAN stack
"certified" might be a good goal for a manufacturer who wants to ship
Linux for this type of system, although we all know how much those
things really matter when it comes to technical issues :)

> For the latter case, it depends on the compatibility of Linux with the
> restricted secure world environment, most notably the secure memory.
> 256k of on chip SRAM is sufficient to do plenty of interesting things
> in the secure world, but sadly, running Linux is not one of them. (I
> know PoP DDR is considered to be secure memory by some vendors as
> well, but its application is not as widespread in the automotive
> world)

Ah, yeah, 256K of ram might be tough to slim Linux down to, but system
sizes keep increasing, so those limitations might be resolved soon
without us having to do anything...

thanks,

greg k-h
