From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Dec 2013 23:41:32 +0000
Subject: [PATCH] ARM: Clean up setup printks a bit
In-Reply-To: <1386199826-8183-1-git-send-email-olof@lixom.net>
References: <1386199826-8183-1-git-send-email-olof@lixom.net>
Message-ID: <20131204234132.GY16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 03:30:26PM -0800, Olof Johansson wrote:
> Clean up the setup ARM printks a bit. Add printk level to a few
> that were missing (CPU: <...> ones, in particular), and switch from
> printk(KERN_* ..) to pr_*().
> 
> Finally, un-wrap some long lines since it makes it harder to grep the
> sources from where an error came from and tweak some cases of indentation.

All good stuff but you missed one :)

> @@ -564,7 +564,7 @@ static void __init setup_processor(void)
>  	 */
>  	list = lookup_processor_type(read_cpuid_id());
>  	if (!list) {
> -		printk("CPU configuration botched (ID %08x), unable "
> +		pr_err("CPU configuration botched (ID %08x), unable "
>  		       "to continue.\n", read_cpuid_id());
>  		while (1);
>  	}
