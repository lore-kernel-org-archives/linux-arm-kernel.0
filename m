From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Nov 2015 16:23:02 -0800
Subject: [PATCH 1/3] devicetree: bindings: Document qcom board compatible
 format
In-Reply-To: <CAOesGMgud5qCdVy8ZM-bZfOksXrb3Wjynko_yRkkhfoQdh9CQg@mail.gmail.com>
References: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
 <1445894712-14350-2-git-send-email-sboyd@codeaurora.org>
 <CAOesGMgud5qCdVy8ZM-bZfOksXrb3Wjynko_yRkkhfoQdh9CQg@mail.gmail.com>
Message-ID: <20151113002301.GG15032@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12, Olof Johansson wrote:
> On Mon, Oct 26, 2015 at 2:25 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > +Examples:
> > +
> > +       "qcom,msm8916-v1-cdp-pm8916-v2.1"
> 
> This is just awkward, but this...
> 
> > +
> > +A CDP board with an msm8916 SoC, version 1 paired with a pm8916 PMIC of version
> > +2.1.
> > +
> > +       "qcom,apq8074-v2.0-2-dragonboard/1-v0.1-512MB-panel-qHD-boot-emmc_sdc1-pm8941-v0.2-pm8909-v2.2-pma8084-v3-pm8110-v1"
> 
> ...this is just too much. It makes no sense to try to linearly
> describe pretty much the whole hardware in the compatible string like
> this when the information should be elsewhere in the DT.
> 
> If this is how it's done, why bother documenting the rest in device
> tree at all? Why not just do a depth-first traversal of the DT and
> create a string out of that and make that the compatible while you're
> at it?

Haha. The entire device is just one big compatible string! I love
it! </sarcasm>

Seriously though, once the PMIC stuff appeared I started thinking
about some way to detect that dynamically because you're right,
it's already in DT somewhere and these huge compatible strings
are gross. Using aliases as Rob suggests should work nicely so
that we can find most of the elements with some simple tree
traversal. In the example above we would be left with
apq8074-v2.0-2-dragonboard/1-v0.1. Is that palatable?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
