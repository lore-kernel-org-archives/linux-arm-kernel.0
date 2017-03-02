From: jbaron@akamai.com (Jason Baron)
Date: Thu, 2 Mar 2017 10:30:50 -0500
Subject: [PATCH] module: set __jump_table alignment to 8
In-Reply-To: <20170301220453.4756-1-david.daney@cavium.com>
References: <20170301220453.4756-1-david.daney@cavium.com>
Message-ID: <7bc6b5af-85e0-5b06-f979-368b8b840a16@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2017 05:04 PM, David Daney wrote:
> For powerpc the __jump_table section in modules is not aligned, this
> causes a WARN_ON() splat when loading a module containing a __jump_table.
>
> Strict alignment became necessary with commit 3821fd35b58d
> ("jump_label: Reduce the size of struct static_key"), currently in
> linux-next, which uses the two least significant bits of pointers to
> __jump_table elements.
>
> Fix by forcing __jump_table to 8, which is the same alignment used for
> this section in the kernel proper.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> ---

Looks good to me.

Reviewed-by: Jason Baron <jbaron@akamai.com>

Thanks,

-Jason
