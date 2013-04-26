From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Apr 2013 14:33:59 +0200
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <CALrVBkuOmu4u9egdzzfn1tU9B-CFe3w85HZQ9s2gpKvYnaSqvA@mail.gmail.com>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <CAFEAcA_xmrHTvR7FxUr3PCKBJY-hZnkeBcqyHksTB4-hqOZS0w@mail.gmail.com>
 <CALrVBkuOmu4u9egdzzfn1tU9B-CFe3w85HZQ9s2gpKvYnaSqvA@mail.gmail.com>
Message-ID: <1577576.O1Cm2pf5KD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 April 2013 17:36:16 Anup Patel wrote:
> On 26 April 2013 17:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 26 April 2013 12:19, Alexander Graf <agraf@suse.de> wrote:
> >> MMIO registers are handled by a different layer than the virtio
> >> console itself. After the virtio refactoring in QEMU, they will
> >> be completely separate drivers.
> >
> > Good point -- we don't really want to be mixing up the
> > transport and the backend. You can see it in the kvmtool
> > patch, in fact -- it introduces an "if this is virtio-console"
> > special case into the mmio.c file which previously was
> > entirely backend agnostic.
> 
> Well, we can always have virtio device specific config registers
> handle by virtio device backends and generic virtio config register
> handled by transport.
> 
> kvmtool patch is hacky because it does not provide virtio device
> specific config read/write callbacks.

Couldn't kvmtool implement the interface used by smh_printch()
for early output instead?

Or if that's not a fitting inteface, maybe a psci call for writing
a character to the console?

	Arnd
