From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 10 Jun 2011 17:12:24 -0600
Subject: [PATCH v4 2/4] dt: add EXPORT_SYMBOL to of_platform_populate
In-Reply-To: <4DF29E5F.8030307@gmail.com>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
	<1307738923-7564-3-git-send-email-robherring2@gmail.com>
	<20110610213756.GC28994@ponder.secretlab.ca>
	<4DF29E5F.8030307@gmail.com>
Message-ID: <20110610231224.GH28994@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 05:44:47PM -0500, Rob Herring wrote:
> On 06/10/2011 04:37 PM, Grant Likely wrote:
> >On Fri, Jun 10, 2011 at 03:48:41PM -0500, Rob Herring wrote:
> >>From: Rob Herring<rob.herring@calxeda.com>
> >>
> >>of_platform_populate is missing an EXPORT_SYMBOL, so add it.
> >>
> >>Cc: Grant Likely<grant.likely@secretlab.ca>
> >>Signed-off-by: Rob Herring<rob.herring@calxeda.com>
> >>---
> >>  drivers/of/platform.c |    1 +
> >>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >>diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >>index dc56a77..8d0f477 100644
> >>--- a/drivers/of/platform.c
> >>+++ b/drivers/of/platform.c
> >>@@ -328,4 +328,5 @@ int of_platform_populate(struct device_node *root,
> >>  	of_node_put(root);
> >>  	return rc;
> >>  }
> >>+EXPORT_SYMBOL(of_platform_populate);
> >
> >I hadn't done this because I hadn't seen a need for calling it from
> >module code.  Do you have a driver that uses it?
> >
> 
> No, but then it doesn't appear that other functions in this file are
> used by modules either. Only of_platform_device_create is used by a
> module (drivers/macintosh) AFAICT.
> 
> Either way, it doesn't really matter to me.

Okay, let's leave this out for the time being.  It is a trivial patch
to add if someone needs it.

g.
