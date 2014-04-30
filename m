From: jays.lee@samsung.com (Jungseok Lee)
Date: Wed, 30 Apr 2014 11:21:00 +0900
Subject: [PATCH v4 3/7] arm64: Introduce a kernel configuration option for
 VA_BITS
In-Reply-To: <20140429144506.GK17007@arm.com>
References: <000301cf6367$ca12e150$5e38a3f0$@samsung.com>
 <20140429144506.GK17007@arm.com>
Message-ID: <007901cf641a$d3fbb710$7bf32530$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 29, 2014 11:45 PM, Catalin Marinas wrote:
> On Tue, Apr 29, 2014 at 05:59:23AM +0100, Jungseok Lee wrote:
> > +config ARM64_VA_BITS
> > +	int "Virtual address space size"
> > +	range 39 39 if ARM64_4K_PAGES && ARM64_3_LEVELS
> > +	range 42 42 if ARM64_64K_PAGES && ARM64_2_LEVELS
> > +	help
> > +	  This feature is determined by a combination of page size and
> > +	  level of translation tables.
> 
> OK, so you are doing the VA bits selection already. But see my other
> email about setting only exposing this and hiding the number of levels
> (though number of levels can be mentioned in the help).

Okay. I will hide the number of levels.

Best Regards
Jungseok Lee
