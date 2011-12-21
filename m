From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 21 Dec 2011 02:57:58 +0000
Subject: [PATCH 1/1] dt: fix some code indent issue in of.h
In-Reply-To: <4EF0D6FD.8070406@gmail.com>
References: <1324404609-3999-1-git-send-email-b29396@freescale.com>
 <4EF0D6FD.8070406@gmail.com>
Message-ID: <7FE21149F4667147B645348EC605788505C492@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robherring2 at gmail.com]
> Sent: Wednesday, December 21, 2011 2:42 AM
> To: Dong Aisheng-B29396
> Cc: devicetree-discuss at lists.ozlabs.org; linux-kernel at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; grant.likely at secretlab.ca; Guo Shawn-R65073
> Subject: Re: [PATCH 1/1] dt: fix some code indent issue in of.h
> Importance: High
> 
> On 12/20/2011 12:10 PM, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> >
> > Checkpatch script will report some warnings for the old coding style:
> > WARNING: suspect code indent for conditional statements (8, 0)
> >         for (child = of_get_next_child(parent, NULL); child != NULL; \
> > [...]
> > +static inline int of_get_child_count(const struct device_node *np)
> >
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > ---
> >  include/linux/of.h |   12 ++++++------
> >  1 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h index
> > f1a490c..95dee0a 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -163,22 +163,22 @@ extern struct device_node *of_find_node_by_name(struct
> device_node *from,
> >  	const char *name);
> >  #define for_each_node_by_name(dn, name) \
> >  	for (dn = of_find_node_by_name(NULL, name); dn; \
> > -	     dn = of_find_node_by_name(dn, name))
> > +		dn = of_find_node_by_name(dn, name))
> >  extern struct device_node *of_find_node_by_type(struct device_node *from,
> >  	const char *type);
> >  #define for_each_node_by_type(dn, type) \
> >  	for (dn = of_find_node_by_type(NULL, type); dn; \
> > -	     dn = of_find_node_by_type(dn, type))
> > +		dn = of_find_node_by_type(dn, type))
> >  extern struct device_node *of_find_compatible_node(struct device_node *from,
> >  	const char *type, const char *compat);  #define
> > for_each_compatible_node(dn, type, compatible) \
> >  	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
> > -	     dn = of_find_compatible_node(dn, type, compatible))
> > +		dn = of_find_compatible_node(dn, type, compatible))
> >  extern struct device_node *of_find_matching_node(struct device_node *from,
> >  	const struct of_device_id *matches);  #define
> > for_each_matching_node(dn, matches) \
> >  	for (dn = of_find_matching_node(NULL, matches); dn; \
> > -	     dn = of_find_matching_node(dn, matches))
> > +		dn = of_find_matching_node(dn, matches))
> >  extern struct device_node *of_find_node_by_path(const char *path);
> > extern struct device_node *of_find_node_by_phandle(phandle handle);
> > extern struct device_node *of_get_parent(const struct device_node
> > *node); @@ -187,13 +187,13 @@ extern struct device_node
> *of_get_next_child(const struct device_node *node,
> >  					     struct device_node *prev);
> >  #define for_each_child_of_node(parent, child) \
> >  	for (child = of_get_next_child(parent, NULL); child != NULL; \
> > -	     child = of_get_next_child(parent, child))
> > +		child = of_get_next_child(parent, child))
> >
> >  extern struct device_node *of_find_node_with_property(
> >  	struct device_node *from, const char *prop_name);  #define
> > for_each_node_with_property(dn, prop_name) \
> >  	for (dn = of_find_node_with_property(NULL, prop_name); dn; \
> > -	     dn = of_find_node_with_property(dn, prop_name))
> > +		dn = of_find_node_with_property(dn, prop_name))
> >
> >  extern struct property *of_find_property(const struct device_node *np,
> >  					 const char *name,
> 
> The old way looks fine to me and indenting like this is commonly used in the
> kernel.
> 
Yes, i was also ok without those annoying warning.
Do you think if we need to fix the checkpatch.pl if the it is commonly used
In the kernel?

Regards
Dong Aisheng
