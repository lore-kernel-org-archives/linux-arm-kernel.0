From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 14 Oct 2013 10:04:55 +0100
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <20131014085931.GB30954@redhat.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <20131012182837.GC2089@redhat.com> <525BAA40.8070103@arm.com>
 <20131014085931.GB30954@redhat.com>
Message-ID: <1381741495.3247.18.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-10-14 at 09:59 +0100, Michael S. Tsirkin wrote:
> On Mon, Oct 14, 2013 at 09:24:32AM +0100, Marc Zyngier wrote:
> > Hi Michael,
> > 
> > On 12/10/13 19:28, Michael S. Tsirkin wrote:
> > > On Fri, Oct 11, 2013 at 03:36:08PM +0100, Marc Zyngier wrote:
> > >> This small patch series adds just enough kernel infrastructure and
> > >> fixes to allow a BE guest to use virtio-mmio on a LE host, provided
> > >> that the host actually supports such madness.
> > >>
> > >> This has been tested on arm64, with some fixes to KVM and a set of
> > >> changes to kvmtool, both which I am posting separately.
> > >>
> > >> A branch containing all the relevant changes is at:
> > >> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/be-on-le-3.12-rc4
> > >>
> > >> Cc: Rusty Russell <rusty@rustcorp.com.au>
> > >> Cc: Michael S. Tsirkin <mst@redhat.com>
> > >> Cc: Pawel Moll <pawel.moll@arm.com>
> > > 
> > > We are changing the spec to make everything LE instead of
> > > the native endian.
> > > 
> > > I think that'll fix the issue in a cleaner way.
> > 
> > While I agree that it would solve the issue completely, it would also
> > break all BE users. Is that really an option?
> 
> I proposed several ways to create "transitional devices"
> which can detect and switch to old interface at run-time.
> 
> Pawel thinks that's not necessary so ...

Don't wipe yourself with my name, please.

You forgot to mention that the devices are versioned and the behavior of
the legacy devices remains unchanged. No existing implementation will be
broken.

Pawe?
