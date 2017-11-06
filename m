From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Nov 2017 15:45:46 -0600
Subject: [RESEND PATCH 1/1] of: Make return types of to_of_node and
 of_fwnode_handle macros consistent
In-Reply-To: <20171102095918.7041-1-sakari.ailus@linux.intel.com>
References: <2117711.dO2rQLXOup@avalon>
 <20171102095918.7041-1-sakari.ailus@linux.intel.com>
Message-ID: <20171106214546.br4excrvclrxfd7f@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 11:59:18AM +0200, Sakari Ailus wrote:
> (Fixed Mauro's e-mail.)
> 
> to_of_node() macro checks whether the fwnode_handle passed to it is not an
> OF node, and if so, returns NULL in order to be NULL-safe. Otherwise it
> returns the pointer to the OF node which the fwnode_handle contains.
> 
> The problem with returning NULL is that its type was void *, which
> sometimes matters. Explicitly return struct device_node * instead.
> 
> Make a similar change to of_fwnode_handle() as well.
> 
> Fixes: d20dc1493db4 ("of: Support const and non-const use for to_of_node()")
> Fixes: debd3a3b27c7 ("of: Make of_fwnode_handle() safer")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi Mauro,
> 
> Could you check whether this addresses the smatch issue with the xilinx
> driver?
> 
> Thanks.
> 
>  include/linux/of.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
