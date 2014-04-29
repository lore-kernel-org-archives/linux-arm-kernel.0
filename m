From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Apr 2014 15:45:06 +0100
Subject: [PATCH v4 3/7] arm64: Introduce a kernel configuration option
 for VA_BITS
In-Reply-To: <000301cf6367$ca12e150$5e38a3f0$@samsung.com>
References: <000301cf6367$ca12e150$5e38a3f0$@samsung.com>
Message-ID: <20140429144506.GK17007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 05:59:23AM +0100, Jungseok Lee wrote:
> +config ARM64_VA_BITS
> +	int "Virtual address space size"
> +	range 39 39 if ARM64_4K_PAGES && ARM64_3_LEVELS
> +	range 42 42 if ARM64_64K_PAGES && ARM64_2_LEVELS
> +	help
> +	  This feature is determined by a combination of page size and
> +	  level of translation tables.

OK, so you are doing the VA bits selection already. But see my other
email about setting only exposing this and hiding the number of levels
(though number of levels can be mentioned in the help).

-- 
Catalin
