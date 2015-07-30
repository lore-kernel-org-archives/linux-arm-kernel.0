From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 30 Jul 2015 20:04:57 +0200
Subject: [PATCH v5 01/10] clk: mediatek: Removed unused dpi_ck clock from
 MT8173
In-Reply-To: <20150730173643.GH3159@codeaurora.org>
References: <1438152754-11970-1-git-send-email-jamesjj.liao@mediatek.com>
 <1438154233.17770.39.camel@mtksdaap41> <20150730173643.GH3159@codeaurora.org>
Message-ID: <1450634.BBmUdb8ZLk@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 30. Juli 2015, 10:36:43 schrieb Stephen Boyd:
> On 07/29, James Liao wrote:
> > Hi Stephen,
> > 
> > Could you help to apply this patch into 4.2?
> > 
> > 
> > Best regards,
> > 
> > James
> > 
> > On Wed, 2015-07-29 at 09:05 +0200, Heiko St?bner wrote:
> > > Am Mittwoch, 29. Juli 2015, 14:52:25 schrieb James Liao:
> > > > The dpi_ck clock can be removed because it not actually used
> > > > in topckgen and subsystems.
> > > > 
> > > > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > > 
> > > From our past discussions this change looks about right, and should
> > > still
> > > become _part of 4.2_, to not have the CLK_TOP_DPI become part of the
> > > devicetree CLK_TOP_DPI.
> 
> Did you mean ABI?

yep, sorry

> 
> > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> Is it being used in DT right now and causing regressions on
> v4.2-rcX? Sorry, I'm trying to understand why this patch matters
> for the 4.2 release.

it's not been used in an actual devicetree file, but as far as I understand it, 
the dt-binding headers themself are also part of the ABI.

And it is new in 4.2, so has not been part of an official release yet.

The reason for the removal from what I understand is that the removed clock is 
not documented at all (it's source, what it does), which got it the "clk_null" 
parent in the first place.


Heiko
