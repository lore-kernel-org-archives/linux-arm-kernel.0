From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 16:13:37 +0000
Subject: [PATCH v5 02/14] ARM: Section based HYP idmap
In-Reply-To: <20130108183848.46302.77369.stgit@ubuntu>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183848.46302.77369.stgit@ubuntu>
Message-ID: <20130114161337.GE23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 01:38:48PM -0500, Christoffer Dall wrote:
> +	pr_info("Setting up static %sidentity map for 0x%llx - 0x%llx\n",
> +		prot ? "HYP " : "",
> +		(long long)addr, (long long)end);

There's no point using 0x%llx and casting to 64-bit longs if the arguments
are always going to be 32-bit.
