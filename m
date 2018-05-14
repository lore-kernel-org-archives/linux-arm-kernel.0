From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 14 May 2018 05:10:22 -0700
Subject: [PATCH 17/18] arm64: convert compat wrappers to C
In-Reply-To: <20180514094640.27569-18-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-18-mark.rutland@arm.com>
Message-ID: <20180514121022.GB11638@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +COMPAT_SYSCALL_DEFINE3(aarch32_statfs64, const char __user *, pathname,
> +		       compat_size_t, sz, struct compat_statfs64 __user *, buf)
> +{
> +	if (sz == 88)
> +		sz = 84;
> +
> +	return kcompat_sys_statfs64(pathname, sz, buf);

This really needs a comment, and it looks very obviously bogus.
In case it isn't it needs a very good explanation.
