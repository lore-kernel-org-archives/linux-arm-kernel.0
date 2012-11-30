From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Nov 2012 12:40:49 +0000
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <CAHod+GcgvxPGUi4p9-qVuRXfyODrYwDvU8u5cChgiXjFYpwOEg@mail.gmail.com>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <20121130121738.GA1960@linaro.org>
 <CAHod+GcgvxPGUi4p9-qVuRXfyODrYwDvU8u5cChgiXjFYpwOEg@mail.gmail.com>
Message-ID: <20121130124049.GO19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 01:28:33PM +0100, Marko Kati? wrote:
> On Fri, Nov 30, 2012 at 1:17 PM, Dave Martin <dave.martin@linaro.org> wrote:
> > This is indeed strange, since there is not much difference to the kernel
> > if CONFIG_ARM_VIRT_EXT is not set.
> >
> > Unless a bug is causing the kernel to trample on some random memory,
> > there is no reason for this to cause I2C devices to disappear.
> >
> > It could be something unrelated, like additional and removal of code
> > changing the position or alignment of other parts of the kernel image.
> >
> > Have you could try undoing parts of the patch to narrow the bug down
> > further?
> >
> > Cheers
> > ---Dave
> 
> No, not yet. As i said my knowledge of what goes on in head.S is limited
> so i'd rather not mess with it.

Well, I think everyone's confused how this change could cause an I2C
device to vanish.  I've been through this code carefully and I don't
see anything that would affect an I2C device here.  The code in question
is not even touching any hardware.

Please post your .config file so we can see how your kernel is configured.
