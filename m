From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Oct 2015 11:24:19 -0700
Subject: [PATCH] spmi-pmic-arb: support configurable number of peripherals
In-Reply-To: <8EEAE898-347B-4CEA-BA4D-0C69897E18EB@gmail.com>
References: <1442267672-11287-1-git-send-email-sboyd@codeaurora.org>
 <55F77451.9070900@codeaurora.org>
 <1442316018.15519.4.camel@mm-sol.com>
 <20150915182728.GA11715@codeaurora.org>
 <561EDAAC.6060800@codeaurora.org>
 <8EEAE898-347B-4CEA-BA4D-0C69897E18EB@gmail.com>
Message-ID: <20151015182419.GH4558@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Ivan T. Ivanov wrote:
> 
> > On Oct 15, 2015, at 1:43 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > 
> > I have to take this back. I missed the part where some pmics are on
> > slave id 2 or slave id 4, so this check isn't going to work. I've
> > adjusted it to use sid % 2 instead and I'll resend these two patches,
> > but I imagine to be more robust we're going to need to add a revid node
> > to the DT under the SID that actually has it. Then we can search the
> > child nodes for a revid compatible node and do the rev probing stuff.
> 
> Ah, yes. We don?t use revision information for now. 
> I suppose we can just remove these reads until we need
> this information?
> 

True, we could just remove all the code and make it look for a
revid node at some later time. But later would be soon because
I'm working on patches to add the read/write/volatile regmap
tables to this driver. I guess I'll just go all the way and do
the revid node part.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
