From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 14:02:08 +0530
Subject: [PATCH V4 3/5] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <f9cc539f87a9c73546fe6671d55d86838886adce.1334548272.git.viresh.kumar@st.com>
References: <cover.1334548272.git.viresh.kumar@st.com>
 <f9cc539f87a9c73546fe6671d55d86838886adce.1334548272.git.viresh.kumar@st.com>
Message-ID: <4F8D2A88.6060309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2012 9:43 AM, Viresh KUMAR wrote:
> diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
> 
> +int spear_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
> +				 struct device_node *np_config,
> +				 struct pinctrl_map **map, unsigned *num_maps)
> +{

> +
> +	*map = kzalloc(sizeof(*map) * count, GFP_KERNEL);
> +	if (!*map)
> +		return -ENOMEM;
> +

Linus,

This was the place that caused crash for me.

I would apply following change in my patch before sending pull request
to Arnd.

-       *map = kzalloc(sizeof(*map) * count, GFP_KERNEL);
+       *map = kzalloc(sizeof(**map) * count, GFP_KERNEL);

--
viresh
