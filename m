From: jays.lee@samsung.com (Jungseok Lee)
Date: Wed, 30 Apr 2014 11:44:13 +0900
Subject: [PATCH v4 2/7] arm64: Decouple page size from level of translation
 tables
In-Reply-To: <20140429144052.GJ17007@arm.com>
References: <000201cf6367$c8084440$5818ccc0$@samsung.com>
 <20140429144052.GJ17007@arm.com>
Message-ID: <007d01cf641e$122f9b20$368ed160$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 29, 2014 11:41 PM, Catalin Marinas wrote:
> Jungseok,

Hi, Catalin

> On Tue, Apr 29, 2014 at 05:59:20AM +0100, Jungseok Lee wrote:
> > +choice
> > +	prompt "Level of translation tables"
> > +	default ARM64_3_LEVELS if ARM64_4K_PAGES
> > +	default ARM64_2_LEVELS if ARM64_64K_PAGES
> > +	help
> > +	  Allows level of translation tables.
> > +
> > +config ARM64_2_LEVELS
> > +	bool "2 level"
> > +	depends on ARM64_64K_PAGES
> > +	help
> > +	  This feature enables 2 levels of translation tables.
> > +
> > +config ARM64_3_LEVELS
> > +	bool "3 level"
> > +	depends on ARM64_4K_PAGES
> > +	help
> > +	  This feature enables 3 levels of translation tables.
> > +
> > +endchoice
> 
> As I mentioned previously
> (http://www.spinics.net/linux/lists/arm-kernel/msg319552.html), just expose options for the VA space
> bits rather than the number of levels.
> You can still keep the number of levels config options but not visible in menuconfig (though I think
> you could also hide them in some header and avoid config altogether). The VA bits config options can
> be:
> 
> VA_BITS_39 if 4K (3 levels)
> VA_BITS_42 if 64K (2 levels)
> VA_BITS_47 if 16K (3 levels)
> VA_BITS_48 if 4K || 16K || 64K (4/4/3 levels depending on page size)
> 
> That's more meaningful to people configuring the kernel.

Okay, I will revise VA_BITS config as hiding the number of levels.

Best Regards
Jungseok Lee
