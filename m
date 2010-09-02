From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 10:08:36 +0100
Subject: [PATCH 10/74] ST SPEAr: Adding support for CLCD on SPEAr3xx/6xx
In-Reply-To: <699e773eaafcd32b38331547247224f9995f2c08.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<699e773eaafcd32b38331547247224f9995f2c08.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100902090836.GH26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int clcd_check(struct clcd_fb *fb, struct fb_var_screeninfo
> +		*var)
> +{
> +	var->xres_virtual = var->xres = (var->xres + 15) & ~15;
> +	var->yres_virtual = var->yres = (var->yres + 1) & ~1;
> +
> +	var->nonstd = 0;
> +	var->accel_flags = 0;

This looks insufficient.
