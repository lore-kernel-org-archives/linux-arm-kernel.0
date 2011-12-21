From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 21 Dec 2011 03:18:19 +0000
Subject: [RFC PATCH v3 1/5] dt: add of_get_child_count helper function
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF176BE92EE2@HQMAIL01.nvidia.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-2-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92EE2@HQMAIL01.nvidia.com>
Message-ID: <7FE21149F4667147B645348EC605788505C50F@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Warren [mailto:swarren at nvidia.com]
> Sent: Wednesday, December 21, 2011 7:59 AM
> To: Dong Aisheng-B29396; linux-kernel at vger.kernel.org
> Cc: linus.walleij at stericsson.com; s.hauer at pengutronix.de;
> rob.herring at calxeda.com; linux-arm-kernel at lists.infradead.org;
> kernel at pengutronix.de; cjb at laptop.org; devicetree-discuss at lists.ozlabs.org
> Subject: RE: [RFC PATCH v3 1/5] dt: add of_get_child_count helper function
> Importance: High
> 
> Dong Aisheng wrote at Tuesday, December 20, 2011 10:41 AM:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> >
> > Currently most code to get child count in kernel are almost same, add
> > a helper to implement this function for dt to use.
> 
> > diff --git a/include/linux/of.h b/include/linux/of.h
> 
> > +static inline int of_get_child_count(const struct device_node *np) {
> > +	return -ENOSYS;
> > +}
> 
> Wouldn't it be better to return 0 here? -ENOSYS would be fine if the function
> returned an error code, but it's really returning a count, and other "dummy"
> functions that return data return 0/NULL already. This would also allow you to
> just use the value directly in all cases rather than having to check for a < 0
> error case.
> 
Good point.
Will update it next.

Regards
Dong Aisheng
