From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 21 Nov 2013 15:56:49 +0000
Subject: [PATCHv5 1/9] of: introduce
 of_property_for_earch_phandle_with_args()
In-Reply-To: <20131121151218.befbb483c0cf09cdcd4cd4dd@nvidia.com>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com> <
 1384853593-32202-2-git-send-email-hdoyu@nvidia.com> <20131121124328.
 46BC1C40A2C@trevor.secretlab.ca> <20131121151218.befbb483c0cf09cdcd4cd4dd@
 nvidia.com>
Message-ID: <20131121155649.48C96C406A3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Nov 2013 15:12:18 +0200, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
> On Thu, 21 Nov 2013 13:43:28 +0100
> Grant Likely <grant.likely@linaro.org> wrote:
> 
> > On Tue, 19 Nov 2013 11:33:05 +0200, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
> > > The following pattern of code is tempting:
> > > 
> > >   for (i = 0; !of_parse_phandle_with_args(np, list, cells, i, args); i++)
> > > 
> > > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > 
> > That's a very minimal commit message. Can you elaborate please.
> 
> The above can be:
> 
> "
>   The following pattern of code is tempting to add a new member for
>   of_property_for_each_*() family as an idiom.
>   
>     for (i = 0;
>         !of_parse_phandle_with_args(np, list, cells, i, args); i++)
>                   <do something with "args">;
> "

I really do like commit messages to be full enough that a future reader
can figure out why a patch was written. ie:

	"Iterating over a property containing a list of phandles with
	arguments is a common operation for device drivers. This patch
	adds a new of_property_for_each_phandle_with_args() macro to
	make the iteration simpler."

g.

> 
> Actual usage is here:
> 
>         int i;
>         struct of_phandle_args args;
> 
>         of_property_for_each_phandle_with_args(dev->of_node, "iommus",
>                                                "#iommu-cells", i, &args) {
>                 pr_debug("%s(i=%d) %s\n", __func__, i, dev_name(dev));
> 
>                 if (!of_find_iommu_by_node(args.np))
>                         return -EPROBE_DEFER;
> 
> Is this acceptable?
