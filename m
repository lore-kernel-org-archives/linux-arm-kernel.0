From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 11 Feb 2012 22:50:40 -0800
Subject: [PATCH V3 1/1] dt: add of_get_child_count helper function
In-Reply-To: <4F36D19A.8050409@mvista.com>
References: <1328980929-5423-1-git-send-email-dong.aisheng@linaro.org>
 <4F36D19A.8050409@mvista.com>
Message-ID: <20120212065040.GA2031@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2012 at 12:37:46AM +0400, Sergei Shtylyov wrote:
> >diff --git a/include/linux/of.h b/include/linux/of.h
> >index a75a831..ae242ef 100644
> >--- a/include/linux/of.h
> >+++ b/include/linux/of.h
> >@@ -195,6 +195,17 @@ extern struct device_node *of_get_next_child(const struct device_node *node,
> >  	for (child = of_get_next_child(parent, NULL); child != NULL; \
> >  	     child = of_get_next_child(parent, child))
> >
> >+static inline int of_get_child_count(const struct device_node *np)
> >+{
> >+	struct device_node *child = NULL;
> >+	int num = 0;
> >+
> >+	while ((child = of_get_next_child(np, child)) != NULL)
> 
>    Doesn't scripts/checkpatch.pl complain here?
> 
That complain actually is not caused by this patch.
I have already sent a patch to fix that issue.
But seemed to get a NACK.
Please refer to:
https://lkml.org/lkml/2011/12/20/236

Regards
Dong Aisheng
