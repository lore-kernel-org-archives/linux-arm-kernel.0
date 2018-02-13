From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Feb 2018 14:33:19 +0000
Subject: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
In-Reply-To: <0ce690ab886d4896506ba916d2d39554@codeaurora.org>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
 <CAHCPf3vt-ZCXgTfCZ-LSW3TSXAk5KBz3wCu-LuTOBdCB+sgGgw@mail.gmail.com>
 <0ce690ab886d4896506ba916d2d39554@codeaurora.org>
Message-ID: <20180213143318.be2dmmmoiafkehqk@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 08, 2018 at 04:24:16PM -0800, Channa wrote:
> On 2018-02-08 08:52, Matt Sealey wrote:
> > On 25 January 2018 at 17:55, Channagoud Kadabi <ckadabi@codeaurora.org>
> > wrote:
> > > Documentation for last level cache controller device tree bindings,
> > > client bindings usage examples.
> > 
> > [snippety snip]
> > 
> > > +- llcc-bank-off:
> > > +       Usage: required
> > > +       Value Type: <u32 array>
> > > +       Definition: Offsets of llcc banks from llcc base address
> > > starting from
> > > +                   LLCC bank0.
> > > +
> > > +- llcc-broadcast-off:
> > > +       Usage: required
> > > +       Value Type: <u32>
> > > +       Definition: Offset of broadcast register from LLCC bank0
> > > address.

> > And if you need to describe register offsets... why aren't you able to
> > use the reg property?
> 
> Reg property did not suit well for my need, so I choose to maintain offsets
> instead.
> 
> The registers in the HW block are organized as
>                 (offset1)    (offset2)     (offset3)     (offset4)
> Base(Block0) -- Block1 -- Block 2 -- Block 3 -- Broadcast_Block
> 
> Each block has identical register mapping. You can think of it as 4
> instances of identical HW.

We have similar in other devices (e.g. GICv3 has multiple instances of
the same register block).

If there's nothing between those blocks, using a reg entry sounds
prefectly reasonable. You can list the broadcast block first, then the
others, or use reg-names.

Thanks,
Mark.
