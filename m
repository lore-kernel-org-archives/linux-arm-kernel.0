From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 7 Apr 2014 08:39:34 -0700
Subject: [PATCH v2 2/5] ARM: zynq: dt: Convert to preprocessor includes
In-Reply-To: <53429754.8080105@topic.nl>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396653256-28397-3-git-send-email-soren.brinkmann@xilinx.com>
 <53423E75.3020008@monstr.eu> <53429754.8080105@topic.nl>
Message-ID: <8db0b480-2c27-4f97-8712-e16fd39d4159@CH1EHSMHS038.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-07 at 02:17PM +0200, Mike Looijmans wrote:
> On 04/07/2014 07:58 AM, Michal Simek wrote:
> >Hi Soren,
> >
> >On 04/05/2014 01:14 AM, Soren Brinkmann wrote:
> >>Convert all Zynq DT files to the dtc preprocessor include syntax.
> >>This allows to include header files in the devicetrees like other
> >>SoC-types already do.
> >>
> >>Inspired-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >>(http://www.spinics.net/lists/arm-kernel/msg319832.html)
> >>
> >>Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >
> >These 4 patches needs more wider discussion if this is helpful or
> >not. Currently I can't see any value in it because everything
> >is just generated and fixed. I think I had the same discussion
> >with Laurent some weeks ago regarding this.
> 
> I would be kinda neutral here. I'd consider it helpful, it improves
> readability (regardless of whether they are generated or hand
> crafted). That's convenient for things like interrupt sensitivity, I
> can't remember whether 4 is level or edge type. On the other hand,
> the clock indices are just as much magic numbers as the memory
> addresses. If I suspect an error in that area, I'd start by lokking
> in /sys/kernel/debug/clk but wouldn't start in the DT.

I agree. Readability is better this way. And whether our generator spits
out magic numbers of these symbolic names should not be a big
difference, is it?

	S?ren
