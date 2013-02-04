From: b32955@freescale.com (Huang Shijie)
Date: Mon, 4 Feb 2013 17:11:37 +0800
Subject: [PATCH 1/2] mtd: gpmi: set the Golois Field bit for mx6q's BCH
In-Reply-To: <1359966688.13791.16.camel@sauron.fi.intel.com>
References: <1359093848-22301-1-git-send-email-b32955@freescale.com>
 <1359966688.13791.16.camel@sauron.fi.intel.com>
Message-ID: <510F7B49.3010809@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?02?04? 16:31, Artem Bityutskiy ??:
> On Fri, 2013-01-25 at 14:04 +0800, Huang Shijie wrote:
>> +#define BF_BCH_FLASH0LAYOUT0_GF(v, x)				\
>> +	((GPMI_IS_MX6Q(x)&&  ((v) == 14))			\
>> +		? (((1)<<  MX6Q_BP_BCH_FLASH0LAYOUT0_GF_13_14)	\
>> +			&  MX6Q_BM_BCH_FLASH0LAYOUT0_GF_13_14)	\
>> +		: 0						\
>> +	)
> Did you consider using static inline functions instead of macro
These macros are only used  when the different archs have different 
definitions about
the some registers. Yes, it's ok to use the functions to replace them.

I am not sure if there is still a need to add the similar macros, if it 
does, i can change to use
the inline functions.

thanks
Huang Shijie
