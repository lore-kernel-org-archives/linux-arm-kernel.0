From: joe@perches.com (Joe Perches)
Date: Tue, 20 Dec 2011 19:06:22 -0800
Subject: [PATCH 1/1] dt: fix some code indent issue in of.h
In-Reply-To: <7FE21149F4667147B645348EC605788505C492@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1324404609-3999-1-git-send-email-b29396@freescale.com>
 <4EF0D6FD.8070406@gmail.com>
 <7FE21149F4667147B645348EC605788505C492@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <1324436782.14214.8.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-12-21 at 02:57 +0000, Dong Aisheng-B29396 wrote:
> > On 12/20/2011 12:10 PM, Dong Aisheng wrote:
> > > From: Dong Aisheng <dong.aisheng@linaro.org>
> > > Checkpatch script will report some warnings for the old coding style:
> > > WARNING: suspect code indent for conditional statements (8, 0)
> > >         for (child = of_get_next_child(parent, NULL); child != NULL; \
> > > [...]
[]
> > > diff --git a/include/linux/of.h b/include/linux/of.h index
[]
> > > @@ -163,22 +163,22 @@ extern struct device_node *of_find_node_by_name(struct
> > device_node *from,
> > >  	const char *name);
> > >  #define for_each_node_by_name(dn, name) \
> > >  	for (dn = of_find_node_by_name(NULL, name); dn; \
> > > -	     dn = of_find_node_by_name(dn, name))
> > > +		dn = of_find_node_by_name(dn, name))
> > The old way looks fine to me and indenting like this is commonly used in the
> > kernel.
> Yes, i was also ok without those annoying warning.
> Do you think if we need to fix the checkpatch.pl if the it is commonly used
> In the kernel?

I don't.  I think it's better for people to realize that
checkpatch is and will always be an imperfect tool and
that they should learn to ignore inappropriate warnings.
