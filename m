From: sarah.a.sharp@linux.intel.com (Sarah Sharp)
Date: Thu, 16 Jan 2014 10:50:44 -0800
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87mwix5anm.fsf@natisbad.org>
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos> <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 <87mwix5anm.fsf@natisbad.org>
Message-ID: <20140116185044.GC18392@xanatos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 08:04:45PM +0100, Arnaud Ebalard wrote:
> Hi David,
> 
> David Laight <David.Laight@ACULAB.COM> writes:
> 
> >> I tried current 3.13.0-rc8 w/ 35773dac5f86 reverted and the result is
> >> the same:
> >
> > That patch only affects an error code and stops the fs code retrying
> > for ever.
> 
> Are you sure? ...
> 
> > Does everything work if you comment out the code in xhci-ring.c that adds
> > NOP TRBs to the ring end in order to stop the LINK TRB appearing in the middle
> > of a TB.
> > The ethernet code needs it, but the disk transfers are (probably) aligned
> > such that they don't.
> 
> ... AFAICT, this is exactly what commit 35773dac5f86 does and reverting
> it does not help. If I am mistaken, can you point which part you want me
> to remove in the code to test?
> 
> I am slowly starting to see a bisect session coming ;-)

Try reverting commit 60e102ac73cd40069d077014c93c86dc7205cb68.  That was
causing issues with another Fresco Logic host.  If that doesn't help,
then yes, please git bisect.

Sarah Sharp
