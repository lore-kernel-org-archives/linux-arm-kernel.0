From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 11 Jan 2018 20:06:23 +1100
Subject: [PATCH linux dev-4.10 3/6] drivers/misc: Add driver for Aspeed
 PECI and generic PECI headers
In-Reply-To: <20180109223126.13093-4-jae.hyun.yoo@linux.intel.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180109223126.13093-4-jae.hyun.yoo@linux.intel.com>
Message-ID: <1515661583.31850.34.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-01-09 at 14:31 -0800, Jae Hyun Yoo wrote:
> +struct peci_rd_ia_msr_msg {
> +       unsigned char target;
> +       unsigned char thread_id;
> +       unsigned short address;
> +       unsigned long value;
> +};

Those types are representing messages on the wire ?

In that case those types aren't suitable. For example "long" will have
a different size and alignment for 32 and 64-bit userspace. There are
size-explicit userspace types available.

Also I didn't see any endianness annotations in there. Is that expected
? IE are those wire format packets ?

Cheers,
Ben.
