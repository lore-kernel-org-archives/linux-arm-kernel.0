From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sat, 11 Jun 2011 10:06:10 -0700
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory
	Power Management
In-Reply-To: <20110610200233.5ddd5a31@infradead.org>
References: <20110610165529.GC2230@linux.vnet.ibm.com>
	<20110610170535.GC25774@srcf.ucam.org>
	<20110610171939.GE2230@linux.vnet.ibm.com>
	<20110610172307.GA27630@srcf.ucam.org>
	<20110610175248.GF2230@linux.vnet.ibm.com>
	<20110610180807.GB28500@srcf.ucam.org>
	<20110610184738.GG2230@linux.vnet.ibm.com>
	<20110610192329.GA30496@srcf.ucam.org>
	<20110610193713.GJ2230@linux.vnet.ibm.com>
	<20110610200233.5ddd5a31@infradead.org>
Message-ID: <20110611170610.GA2212@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 08:02:33PM -0700, Arjan van de Ven wrote:
> On Fri, 10 Jun 2011 12:37:13 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Fri, Jun 10, 2011 at 08:23:29PM +0100, Matthew Garrett wrote:
> > > On Fri, Jun 10, 2011 at 11:47:38AM -0700, Paul E. McKenney wrote:
> > > 
> > > > And if I understand you correctly, then the patches that Ankita
> > > > posted should help your self-refresh case, along with the
> > > > originally intended the power-down case and special-purpose use
> > > > of memory case.
> > > 
> > > Yeah, I'd hope so once we actually have capable hardware.
> > 
> > Cool!!!
> > 
> > So Ankita's patchset might be useful to you at some point, then.
> > 
> > Does it look like a reasonable implementation?
> 
> as someone who is working on hardware that is PASR capable right now,
> I have to admit that our plan was to just hook into the buddy allocator,
> and use PASR on the top level of buddy (eg PASR off blocks that are
> free there, and PASR them back on once an allocation required the block
> to be broken up)..... that looked the very most simple to me.
> 
> Maybe something much more elaborate is needed, but I didn't see why so
> far.

If I understand correctly, you face the same issue that affects
transparent huge pages, but on a much larger scale.  If you have even
one non-moveable allocation in a given top-level buddy block, you won't
be able to PASR that block.

In addition, one of the things that Ankita's patchset is looking to do
is to control allocations in a given region, so that the region can be
easily evacuated.  One use for this is to power off regions of memory,
another is to PASR off regions of memory, and a third is to ensure that
large regions of memory are available for when needed by media codecs
(e.g., cameras), but can be used for other purposes when the media codecs
don't need them (e.g., when viewing photos rather than taking them).


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.15.1307811980.24103.linux-arm-kernel@lists.infradead.org>

							Thanx, Paul
