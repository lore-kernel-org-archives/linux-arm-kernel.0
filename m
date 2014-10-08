From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Oct 2014 10:28:02 +0100
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <1412712777.32313.130.camel@smoke>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001145602.GB13689@redhat.com>
 <1412361303.32313.24.camel@smoke>
 <20141007134450.GE27464@redhat.com>
 <1412707320.32313.100.camel@smoke>
 <20141007184520.GI27464@redhat.com>
 <1412712777.32313.130.camel@smoke>
Message-ID: <20141008092802.GF27216@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 09:12:57PM +0100, Geoff Levand wrote:
> Hi Vivek,
> 
> On Tue, 2014-10-07 at 14:45 -0400, Vivek Goyal wrote:
> > On Tue, Oct 07, 2014 at 11:42:00AM -0700, Geoff Levand wrote:
> > > Adding purgatory code to arm64 is low priority, and I currently
> > > have no plan to do that.  Users are asking for kdump, and proper
> > > UEFI support, so that is what I will work towards.
> > 
> > I think having purgatory enabled is very important here as in kernel
> > you are hardcoding that one of the segments is DTB and doing all the
> > magic tricks w.r.t putting a magic number. 
> 
> I don't argue that having purgatory code could be useful, but as of
> now, enabling the other features is what I'll work towards.
>  
> Regarding the device tree magic number, I'm wondering if you missed
> that the device tree has a header, and that header has a magic
> number.  See here:
> 
>   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/dtc/libfdt/fdt.h#n6

As I mentioned elsewhere, regardless of whether we can detect if a
segment is a DTB, we're still encoding the policy of what to do with
that within the kernel, and there are cases that is problematic for.

Leaving at least the register setup to the caller's discretion (by way
of a userspace provided purgatory) avoids those problems entirely.

kexec_load_file is more complicated in that regard due to the less
general interface provided.

Mark.
