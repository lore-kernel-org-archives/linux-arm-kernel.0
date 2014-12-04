From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Dec 2014 18:29:46 +0000
Subject: [PATCH v12 7/7] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <1417671360-53399-1-git-send-email-wangnan0@huawei.com>
References: <1417671172-52915-1-git-send-email-wangnan0@huawei.com>
 <1417671360-53399-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20141204182946.GO11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 01:36:00PM +0800, Wang Nan wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 89c4b5c..8281cea 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -59,6 +59,7 @@ config ARM
>  	select HAVE_MEMBLOCK
>  	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
>  	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
> +	select HAVE_OPTPROBES if (!THUMB2_KERNEL)

Please don't add extra parens where they're not required.

> +#define MAX_COPIED_INSN	(DIV_ROUND_UP(RELATIVEJUMP_SIZE, sizeof(kprobe_opcode_t)))

ditto.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
