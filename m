From: horms@verge.net.au (Simon Horman)
Date: Thu, 24 Mar 2016 09:19:58 +0900
Subject: [PATCH v2 1/2] ARM: dts: r8a73a4: Remove unnecessary
 clock-output-names properties
In-Reply-To: <CAMuHMdW-uq_6PkdaPhd++h1sYUEnwrQYRqops3utUu8nREaj8g@mail.gmail.com>
References: <1458695203-9950-1-git-send-email-horms+renesas@verge.net.au>
 <1458695203-9950-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdW-uq_6PkdaPhd++h1sYUEnwrQYRqops3utUu8nREaj8g@mail.gmail.com>
Message-ID: <20160324001957.GA26615@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 08:42:49AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Mar 23, 2016 at 2:06 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > * Fixed rate and fixed factor clocks do not require an
> >   clock-output-names property.
> > * Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
> >   optional") Renesas div6 clocks do not require a clock-output-names
> >   property.
> >
> > In the above cases there is only one clock output and its name is taken
> > from that of the clock node.  Accordingly, remove the unnecessary
> > clock-output-names properties and as necessary update the node names.
> >
> > The clock-output-names property is left in place for the zb_clk which is
> > thus treated as a special case as the MSTP clock driver (clk-mstp.c)
> > explicitly looks for a clock named zb_clk for the r8a73a4 and sh73a0 SoCs.
> 
> ... a clock with node name zb_clk ...
> 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> With the above change:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up with the change you suggest.
Likewise for patch 2/2.
