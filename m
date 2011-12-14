From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Dec 2011 12:04:28 -0600
Subject: [RFC PATCH v2 1/4] dt: add of_get_child_number helper function
In-Reply-To: <1323878622-26602-2-git-send-email-b29396@freescale.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-2-git-send-email-b29396@freescale.com>
Message-ID: <4EE8E52C.1030506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dong,

On 12/14/2011 10:03 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Currently most code to get child number in kernel are almost same,
> add a helper to implement this function for dt to use.
>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  include/linux/of.h |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4948552..09d53dc 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -189,6 +189,18 @@ extern struct device_node *of_get_next_child(const struct device_node *node,
>  	for (child = of_get_next_child(parent, NULL); child != NULL; \
>  	     child = of_get_next_child(parent, child))
>  
> +static inline int of_get_child_number(struct device_node *np)

I would call this of_get_child_count instead.

Rob
