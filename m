From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Mar 2016 10:30:16 +0900
Subject: [PATCH] ARM: dts: r8a7790: Remove unnecessary clock-output-names
 properties
In-Reply-To: <CAMuHMdUsHZDGO_SjEt-TDZ1hr=6eXg87AQ_wBS8A1yKTcSPbqw@mail.gmail.com>
References: <1458089041-22994-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUsHZDGO_SjEt-TDZ1hr=6eXg87AQ_wBS8A1yKTcSPbqw@mail.gmail.com>
Message-ID: <20160317013015.GG17728@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 09:44:35AM +0100, Geert Uytterhoeven wrote:
> On Wed, Mar 16, 2016 at 1:44 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > * Fixed rate and fixed factor clocks do not require an
> >   clock-output-names property.
> > * Since 1fae91ec99fb ("clk: shmobile: div6: Extract cpg_div6_register()")
> >   Renesas div6 clocks do not require a clock-output-names property.
> 
> Are you sure you don't mean its parent, commit 07705583e920fef6
> ("clk: shmobile: div6: Make clock-output-names optional")? ;-)
> 
> > In the above cases there is only one clock output and its name is taken
> > from that of the clock node.
> >
> > Accordingly, remove the unnecessary clock-output-names properties and
> > as necessary the nodes.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> With the commit reference fixed:
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have corrected the commit reference and queued this
up as a cleanup for v4.7.

I'll go ahead and do a sweep of the reset of the DTS files
and post patches accordingly.
