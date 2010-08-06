From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Fri, 6 Aug 2010 17:31:19 +0200
Subject: [PATCH 07/10] ftrace: pass KBUILD_CFLAGS to record_mcount.pl
In-Reply-To: <20100803164247.GA6133@debian>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-8-git-send-email-rabin@rab.in>
	<20100803164247.GA6133@debian>
Message-ID: <20100806153114.GA5345@nowhere>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 03, 2010 at 10:12:47PM +0530, Rabin Vincent wrote:
> Steven, Frederic,
> 
> I'd like to resurrect this old ARM dynamic ftrace patchset.  It still
> applies on next except for a small merge conflict in one of the
> ARM-specific patches.
> 
> On Sat, Mar 13, 2010 at 12:19:44PM +0530, Rabin Vincent wrote:
> > On ARM, we have two ABIs, and the ABI used is controlled via a config
> > option.  Object files built with one ABI can't be merged with object
> > files built with the other ABI.  So, record_mcount.pl needs to use the
> > same compiler flags as the kernel when generating the object file with
> > the mcount locations.  Ensure this by passing CFLAGS to the script.
> > 
> > Signed-off-by: Rabin Vincent <rabin@rab.in>
> 
> This is the only non-arch/arm/ patch in the series which doesn't have
> either of your Acked-bys, so if you'd be willing to ack it, I'll send in
> the lot via rmk's ARM patch system for .37.
> 
> Alternatively, this one and "[PATCH 03/10] ftrace: allow building
> without frame pointers" could go in via the tracing tree for .36?  Then
> I'll send in the ARM specific stuff for .37 via the ARM tree.
> 
> Thanks,
> Rabin



I'll let Steve handling this one as I have few skills with things that touch
scripts/recordmcount.pl :)
