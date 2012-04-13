From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Apr 2012 10:13:31 -0600
Subject: [PATCH V3 3/4] pinctrl: Add SPEAr3xx pinctrl drivers
In-Reply-To: <61fe5fe87fdddfc66d21d82b1039de3782b50201.1334207964.git.viresh.kumar@st.com>
References: <cover.1334207964.git.viresh.kumar@st.com>
 <61fe5fe87fdddfc66d21d82b1039de3782b50201.1334207964.git.viresh.kumar@st.com>
Message-ID: <4F8850AB.3090109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2012 11:24 PM, Viresh Kumar wrote:
> This adds pinctrl driver for SPEAr3xx family. SPEAr3xx family supports three
> families: SPEAr300, SPEAr310 and SPEAr320.

> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl_spear.txt

> +Required subnode-properties:
> +- st,pins : An array of strings. Each string contains the name of a pin or
> +  group.
> +- st,function: A string containing the name of the function to mux to the pin or
> +  group. See the SPEAr's TRM to determine which are valid for each pin or group.
> +
> +  Valid values for group and function names can be found from looking at the
> +  group and function arrays in driver files:
> +  drivers/pinctrl/spear/pinctrl-spear3*0.c

It might be nice to enumerate the pin/group/function names here, but if
they're identical to the TRM I guess it's fine not to.

Looking at the Tegra binding docs, I see I forgot to enumerate the
function names although I did enumerate everything else.
