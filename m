From: mgorman@suse.de (Mel Gorman)
Date: Mon, 13 Apr 2015 11:04:26 +0100
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <20150413095645.GQ12732@n2100.arm.linux.org.uk>
References: <20150210113230.GJ8656@n2100.arm.linux.org.uk>
 <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
 <20150326114612.GD8656@n2100.arm.linux.org.uk>
 <20150326123028.GM4701@suse.de>
 <CADtm3G4Lb=u+BAHZF+O+RgB4VS9iW8epCPJ9ssBTj=+p3+h==Q@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D104A310D42397@CNBJMBX05.corpusers.net>
 <20150410112430.GB12732@n2100.arm.linux.org.uk>
 <20150413010913.GA15225@corellia.local>
 <20150413012115.GB15225@corellia.local>
 <20150413095645.GQ12732@n2100.arm.linux.org.uk>
Message-ID: <20150413100425.GB14842@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 10:56:45AM +0100, Russell King - ARM Linux wrote:
> On Sun, Apr 12, 2015 at 06:21:15PM -0700, Gregory Fong wrote:
> > On Sun, Apr 12, 2015 at 06:09:13PM -0700, Gregory Fong wrote:
> > > And now we see 83 slab_reclaimable + 846 slab_unreclaimable adds up
> > > correctly to the total of 929.
> > > 
> > > The patch below will end up with the correct count.
> > > 
> > 
> > Sorry, messed up the patch formatting.  Here it is fixed:
> 
> So now the question is: do we fix this, or do we use the generic version?
> Given that the total number of slab pages can be easily deduced from the
> generic statistics, do we need to modify the generic version to print an
> additional line with this?

Whatever ARM decides, I do not think the generic version needs to do
a PFN walk to recaluate the SLAB statistics. The slab_reclaimable and
slab_unreclaimable stats based on the vmstat counters is sufficient. 

-- 
Mel Gorman
SUSE Labs
