From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 28 Feb 2012 17:05:28 +0200
Subject: [PATCHv2 5/6] ARM: OMAP4: hwmod_data: Do not get DSP out of
 reset at boot time
In-Reply-To: <alpine.DEB.2.00.1202280330140.11716@utopia.booyaka.com>
References: <1330096546-20477-1-git-send-email-t-kristo@ti.com>
 <1330096546-20477-6-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1202280330140.11716@utopia.booyaka.com>
Message-ID: <1330441528.2116.46.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-28 at 03:31 -0700, Paul Walmsley wrote:
> Hi
> 
> On Fri, 24 Feb 2012, Tero Kristo wrote:
> 
> > From: Rajendra Nayak <rnayak@ti.com>
> > 
> > With no driver handling DSP, if brought out of reset, it stays
> > active and does not assert standby. This leads to IVAHD powerdomain not
> > transitioning and hence preventing chip retention.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Please test this series:
> 
>    http://marc.info/?l=linux-omap&m=133040749621183&w=2
> 
> in lieu of this patch.
> 
> 
> - Paul

Just tried the CSWR set on top of your branch with this patch reverted
and it works nicely. I'll drop this patch out from the next version.

-Tero
