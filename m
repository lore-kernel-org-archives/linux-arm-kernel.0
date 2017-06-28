From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 28 Jun 2017 08:51:10 -0700
Subject: [RFC 3/5] drivers: boot_constraint: Add boot_constraints_disable
 kernel parameter
In-Reply-To: <f2fff03550bd14e1334de3faa1a79c0f8651b09d.1498642745.git.viresh.kumar@linaro.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <f2fff03550bd14e1334de3faa1a79c0f8651b09d.1498642745.git.viresh.kumar@linaro.org>
Message-ID: <04d6732a-3a2e-2f04-1d6e-a4ac51470db5@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2017 03:26 AM, Viresh Kumar wrote:
> Users must be given an option to discard any constraints set by
> bootloaders. For example, consider that a constraint is set for the LCD
> controller's supply and the LCD driver isn't loaded by the kernel. If
> the user doesn't need to use the LCD device, then he shouldn't be forced
> to honour the constraint.
> 
> We can also think about finer control of such constraints with help of
> some sysfs files, but a kernel parameter is fine to begin with.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 ++
>  drivers/base/boot_constraint.c                  | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7737ab5d04b2..35e8a298bfc1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -426,6 +426,8 @@
>  			embedded devices based on command line input.
>  			See Documentation/block/cmdline-partition.txt
>  
> +	boot_constraints_disable = Do not set any boot constraints for devices.
> +

No '=' sign.  That is only used when there is a following parameter value.


>  	boot_delay=	Milliseconds to delay each printk during boot.
>  			Values larger than 10 seconds (10000) are changed to
>  			no delay (0).


-- 
~Randy
