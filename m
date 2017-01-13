From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jan 2017 12:06:14 +0000
Subject: [PATCH] arm64/mm: use phys_addr_t
In-Reply-To: <20170113114553.GD26804@leverpostej>
References: <1484287175-14342-1-git-send-email-miles.chen@mediatek.com>
 <20170113112205.GA26804@leverpostej>
 <CAKv+Gu__4S+0B39SXn46sqxsH0OXeusotZOBmvzZmw-yRRzdjA@mail.gmail.com>
 <20170113114553.GD26804@leverpostej>
Message-ID: <20170113120614.GE3253@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 11:45:54AM +0000, Mark Rutland wrote:
> On Fri, Jan 13, 2017 at 11:27:48AM +0000, Ard Biesheuvel wrote:
> > On 13 January 2017 at 11:22, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Fri, Jan 13, 2017 at 01:59:35PM +0800, miles.chen at mediatek.com wrote:
> > >> From: Miles Chen <miles.chen@mediatek.com>
> > >>
> > >> Use phys_addr_t instead of unsigned long for the
> > >> return value of __pa(), make code easy to understand.
> > >>
> > >> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > >
> > > This looks sensible to me. It's consistent with the types these
> > > variables are compared against, and with the types of function
> > > parameters these are passed as.
> > >
> > 
> > Indeed. But doesn't it clash with Laura's series?
> 
> Good point.
> 
> Yes, but only for the RHS of the assignment changing. This'll need to be
> rebased atop of the arm64 for-next/core branch, or Catalin/Will might
> fix it up when applying, perhaps?

Yeah, it's dead easy for me to fix up.

Will
