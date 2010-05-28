From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 05:20:29 +0100
Subject: [PATCH] s5pv210: Change the base ram address to 0x3000'0000
In-Reply-To: <AANLkTikfCdHgzgRjVikeGYg5wK_meh3NyDRCOzs6j6uc@mail.gmail.com>
References: <20100528023559.GA8174@july>
	<20100528035352.GO4720@trinity.fluff.org>
	<AANLkTikfCdHgzgRjVikeGYg5wK_meh3NyDRCOzs6j6uc@mail.gmail.com>
Message-ID: <20100528042029.GS4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 01:02:24PM +0900, Kyungmin Park wrote:
> On Fri, May 28, 2010 at 12:53 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> > On Fri, May 28, 2010 at 11:35:59AM +0900, Kyungmin Park wrote:
> >> s5pc110 (aka s5pv210) has 2 DRAM port and used it both usually.
> >> Assume DMC0 starts with 0x2000'0000 with 128MiB.
> >> DMC1 starts with 0x4000'0000 with 128MiB.
> >> Note that DMC1 has to start address 0x4000'0000 at least.
> >>
> >> Then there's too much memory hole 0x1800'0000 (128MiB + 256MiB)
> >>
> >> To reduce memory waste, the DMC0 start with 0x3000'0000.

but you just said DMC0 starts at 0x2... ? Is this reconfigurable via
software, if so can it be moved once initialisation si done? how fixed
is this?
 
> Hi,
> 
> >
> > We should be using SPARSEMEM now, is it not reducing any wastage
> > in virtual memory space?
> 
> Please consider the older kernel also. and most systems are designed
> for 0x3000'0000.

Ok, will a kernel with the base-address set to 0x3... work when loaded
on a system with RAM starting at 0x2... ? I'm not sure the answer to this
question.

I'd rather try and get one kernel working on all systems with the S5PV210
if possible instead of havign to pick which ones have certain base addresses


> >
> > How will the user change their board to deal with this change to hte
> > kernel?
> 
> Now we got the these memory
> DMC0 has 128MiB and DMC1 has 512MiB.
> Then it uses the memory from 0x2000'0000 to 0x5fff'ffff. it used 1GiB
> memory address space.
> Of course we can enable thie HIGHMEM but older kernel doesn't support it fully.
> Also I hope to use the 3G/1G memory scheme.

Given you can only get 1G of real memory into a S5PV210, is it really
necessary to go to 3G/1G? What problems are there with 2/2 split?

> How to you think?

I thought that when the s5pv210 was submitted we enabled the SPARSMEM
support so that whatever DRAM configuration we could handle it within
a single kernel.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
