From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 15 Dec 2011 05:49:54 +0000
Subject: [RFC PATCH v2 1/4] dt: add of_get_child_number helper function
In-Reply-To: <CACxGe6tQO=5oGXjpZ_VD+Pzs+mPKgdciKBHiA6YBf4PHfe_Q7g@mail.gmail.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-2-git-send-email-b29396@freescale.com>
 <4EE8E52C.1030506@gmail.com>
 <CACxGe6tQO=5oGXjpZ_VD+Pzs+mPKgdciKBHiA6YBf4PHfe_Q7g@mail.gmail.com>
Message-ID: <7FE21149F4667147B645348EC6057885053036@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: glikely at secretlab.ca [mailto:glikely at secretlab.ca] On Behalf Of
> Grant Likely
> Sent: Thursday, December 15, 2011 5:41 AM
> To: Rob Herring
> Cc: Dong Aisheng-B29396; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linus.walleij at stericsson.com;
> s.hauer at pengutronix.de; Guo Shawn-R65073; kernel at pengutronix.de
> Subject: Re: [RFC PATCH v2 1/4] dt: add of_get_child_number helper
> function
> Importance: High
> 
> On Wed, Dec 14, 2011 at 11:04 AM, Rob Herring <robherring2@gmail.com>
> wrote:
> > Dong,
> >
> > On 12/14/2011 10:03 AM, Dong Aisheng wrote:
> >> From: Dong Aisheng <dong.aisheng@linaro.org>
> >>
> >> Currently most code to get child number in kernel are almost same,
> >> add a helper to implement this function for dt to use.
> >>
> >> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> >> Cc: Grant Likely <grant.likely@secretlab.ca>
> >> Cc: Rob Herring <rob.herring@calxeda.com>
> >> ---
> >> ?include/linux/of.h | ? 17 +++++++++++++++++
> >> ?1 files changed, 17 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/include/linux/of.h b/include/linux/of.h index
> >> 4948552..09d53dc 100644
> >> --- a/include/linux/of.h
> >> +++ b/include/linux/of.h
> >> @@ -189,6 +189,18 @@ extern struct device_node
> >> *of_get_next_child(const struct device_node *node,
> >> ? ? ? for (child = of_get_next_child(parent, NULL); child != NULL; \
> >> ? ? ? ? ? ?child = of_get_next_child(parent, child))
> >>
> >> +static inline int of_get_child_number(struct device_node *np)
> >
> > I would call this of_get_child_count instead.
> 
> I agree.
> 
Yes, will change to that name.
Thanks for the suggestion.

Regards
Dong Aisheng
