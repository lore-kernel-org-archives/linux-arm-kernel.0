From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Apr 2012 10:18:45 -0600
Subject: [PATCH V3 4/4] SPEAr3xx: Add pinctrl support for boards
In-Reply-To: <81b04bd4fe751633802e539d724facce80e600a4.1334207964.git.viresh.kumar@st.com>
References: <cover.1334207964.git.viresh.kumar@st.com>
 <81b04bd4fe751633802e539d724facce80e600a4.1334207964.git.viresh.kumar@st.com>
Message-ID: <4F8851E5.7050509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2012 11:24 PM, Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Just a couple of minor comments below.

> diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts

> +		pinmux at 99000000 {
> +			st,pinmux-mode=<2>;

spaces around = here for consistency?

> +			state_default: pinmux {
> +				i2c0 {
> +					st,pins = "i2c0_grp";
> +					st,function = "i2c0";
> +				};

Do the group names need the "_grp" suffix? If that's what's in your TRM,
it's fine by me, but I'd guess that isn't the case, and if so I'd say
either drop the _grp suffix here, or enhance the binding documentation
to mention the need to add this suffix when writing the .dts file.
