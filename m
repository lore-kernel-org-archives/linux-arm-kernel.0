From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Jun 2011 23:06:48 +0200
Subject: [PATCH v4 1/4] dt: check root nodes for match on
	of_platform_populate
In-Reply-To: <1307738923-7564-2-git-send-email-robherring2@gmail.com>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
	<1307738923-7564-2-git-send-email-robherring2@gmail.com>
Message-ID: <201106102306.48426.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 June 2011 22:48:40 Rob Herring wrote:
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 9b785be..dc56a77 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -318,6 +318,8 @@ int of_platform_populate(struct device_node *root,
>                 return -EINVAL;
>  
>         for_each_child_of_node(root, child) {
> +               if (!of_match_node(matches, child))
> +                       continue;
>                 rc = of_platform_bus_create(child, matches, parent, true);
>                 if (rc)
>                         break;


Why doesn't of_platform_populate just call of_platform_bus_create on the
root node? That should normally take care of matching all children.

	Arnd
