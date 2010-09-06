From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 6 Sep 2010 15:13:36 +0530
Subject: [PATCH 10/74] ST SPEAr: Adding support for CLCD on SPEAr3xx/6xx
In-Reply-To: <20100902090836.GH26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<699e773eaafcd32b38331547247224f9995f2c08.1283161023.git.viresh.kumar@st.com>
	<20100902090836.GH26319@n2100.arm.linux.org.uk>
Message-ID: <4C84B7C8.8040609@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2010 2:38 PM, Russell King - ARM Linux wrote:
>> +static int clcd_check(struct clcd_fb *fb, struct fb_var_screeninfo
>> +		*var)
>> +{
>> +	var->xres_virtual = var->xres = (var->xres + 15) & ~15;
>> +	var->yres_virtual = var->yres = (var->yres + 1) & ~1;
>> +
>> +	var->nonstd = 0;
>> +	var->accel_flags = 0;
> 
> This looks insufficient.
> .
> 

Ok. will use clcdfb_check.
