From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Jun 2013 00:23:26 +0200
Subject: [PATCH v5 01/22] pinctrl: generic: Add DT bindings
In-Reply-To: <CACRpkdYev+hapkM075Sw7Yi0u+XpRvL74SwT39DV1aV1RtHC+Q@mail.gmail.com>
References: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1370989371-30846-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdYev+hapkM075Sw7Yi0u+XpRvL74SwT39DV1aV1RtHC+Q@mail.gmail.com>
Message-ID: <1961223.akELqavQP8@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wednesday 12 June 2013 11:24:38 Linus Walleij wrote:
> On Wed, Jun 12, 2013 at 12:22 AM, Laurent Pinchart wrote:
> > Document DT properties for the generic pinctrl parameters and add a
> > parser function.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> It appears we have a race here, as something like three people,
> or four, happened to do generic pinconf bindings at the same time.
> 
> Yesterday I applied Heiko St?bners patch
> "pinctrl: add function to parse generic pinconfig properties from a dt node"
> doing basically the same thing. With subtle differences...
> but it already supports schmittrigging and some more.
> 
> It appears to be close to your idea though!
> 
> Would it be possible for you to look at what I have on my "devel" branch
> now (same as submitted for -next), rebase on that and patch any problems?

OK, I will do so. In the meantime I'll resubmit this patch series without the 
pinconf DT bindings for inclusion in v3.11, and will then post follow-up 
patches to add pinconf DT support, for v3.11 or v3.12 depending on the timing.

> > +               if (param->flag) {
> > +                       ret = of_property_read_bool(np, param->property)
> > +                           ? 0 : -EINVAL;
> > +                       val = 1;
> > +               } else {
> > +                       ret = of_property_read_u32(np, param->property,
> > &val); +               }
> 
> This construct is done differently in Heiko's code, please review it so we
> know we have a nice, efficient parser.

-- 
Regards,

Laurent Pinchart
