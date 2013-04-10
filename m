From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 11:09:37 +0900
Subject: [PATCH] ARM: shmobile: Include all 2 GiB of memory on APE6EVM
In-Reply-To: <CANqRtoSvoyCDGMtLof68y2q1feiEtE=HXMi1=sTi-rOKexAuhQ@mail.gmail.com>
References: <20130408014444.18767.64441.sendpatchset@w520>
 <20130409123433.GD15412@verge.net.au>
 <20130409161410.GA16003@verge.net.au>
 <CANqRtoTCYVY9Q6-2wUshSxZzXNsUx4xdY+phf2ZyHmwSyj4SRw@mail.gmail.com>
 <20130410003535.GA2462@verge.net.au>
 <CANqRtoSvoyCDGMtLof68y2q1feiEtE=HXMi1=sTi-rOKexAuhQ@mail.gmail.com>
Message-ID: <20130410020936.GI11105@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:38:49AM +0900, Magnus Damm wrote:
> Hi Simon, Arnd,
> 
> On Wed, Apr 10, 2013 at 9:35 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Apr 10, 2013 at 07:27:41AM +0900, Magnus Damm wrote:
> >> Hi Simon,
> >>
> >> On Wed, Apr 10, 2013 at 1:14 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > On Tue, Apr 09, 2013 at 09:34:34PM +0900, Simon Horman wrote:
> >> >> On Mon, Apr 08, 2013 at 10:44:44AM +0900, Magnus Damm wrote:
> >> >> > From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> >> >> >
> >> >> > Add 1GiB of DRAM at 0x2_0000_0000
> >> >> >
> >> >> > Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> >> >> > Signed-off-by: Magnus Damm <damm@opensource.se>
> >> >>
> >> >> Thanks, queued up in the boards-ape6evm branch.
> >> >
> >> > I have dropped this patch as it appears to prevent
> >> > the board from booting.
> >>
> >> Is it possible that LPAE=n and HIGHMEM=y in your particular kernel
> >> configuration?
> >
> > Yes, I have confirmed that is what using the ape6evm_defconfig results in.
oup >
> >> >From what I can tell HIGHMEM is broken in cases of large amounts of
> >> memory. Try disabling that as a short-term workaround. Then of course
> >> someone needs to track down why the generic code doesn't work as
> >> expected.
> >
> > I have confirmed that disabling HIGHMEM allows the board to boot
> > with this patch applied.
> 
> Thanks for checking.
> 
> So HIGHMEM without LPAE seems busted on boards using more than 32-bits
> for memory.
> 
> I'd like to help out fixing this issue, but I'd like to make sure that
> no one else is working on this.
> 
> Arnd, are you aware on any work related to making HIGHMEM work without LPAE?
> 
> > Should I prepare a patch to the defconfig to accompany this patch?
> 
> I believe that would affect a bunch of boards so I don't think that is
> necessary at this point. Thanks anyway.
> 
> Would it be possible for you to queue up this change in a APE6EVM topic branch?

Sure, I have pushed topic/ape6evm-2gb.

I also plan to push topic/ape6evm-2gb+renesas-next-20130410v2
once I have finalised renesas-next-20130410v2.
