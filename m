From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 27 Apr 2012 11:28:37 +0800
Subject: [PATCH v4 1/4] dt: add of_get_child_count helper function
In-Reply-To: <4F9976AB.1020502@wwwdotorg.org>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <4F9976AB.1020502@wwwdotorg.org>
Message-ID: <20120427032831.GE26070@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 12:24:11AM +0800, Stephen Warren wrote:
> On 04/26/2012 08:40 AM, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > Currently most code to get child count in kernel are almost same,
> > add a helper to implement this function for dt to use.
> 
> > diff --git a/include/linux/of.h b/include/linux/of.h
> 
> > +static inline int of_get_child_count(const struct device_node *np)
> > +{
> > +	struct device_node *child = NULL;
> 
> You don't actually need to initialize child here. It doesn't really
> matter here, but in a more complex function, it might hide a
> used-before-initialized error.
> 
Correct, i could change it.

Regards
Dong Aisheng
