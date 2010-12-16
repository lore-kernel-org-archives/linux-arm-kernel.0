From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Dec 2010 12:55:28 +0000
Subject: [PATCH v5 4/5] msm: hotplug: support cpu hotplug on msm
In-Reply-To: <1292482456-22690-5-git-send-email-johlstei@codeaurora.org>
References: <1292482456-22690-1-git-send-email-johlstei@codeaurora.org>
	<1292482456-22690-5-git-send-email-johlstei@codeaurora.org>
Message-ID: <AANLkTinzVP4rjOZM0PZQGYBNm+z-O=S0h6vo1QVoh+ps@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2010 06:54, Jeff Ohlstein <johlstei@codeaurora.org> wrote:
> --- /dev/null
> +++ b/arch/arm/mach-msm/hotplug.c
[...]
> +static inline void platform_do_lowpower(unsigned int cpu)
> +{
> + ? ? ? /* Just enter wfi for now. TODO: Properly shut off the cpu. */
> + ? ? ? for (;;) {
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* here's the WFI
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? asm(".word ? ? ?0xe320f003\n"
> + ? ? ? ? ? ? ? ? ? :
> + ? ? ? ? ? ? ? ? ? :
> + ? ? ? ? ? ? ? ? ? : "memory", "cc");

Is this for an ARMv7 platform? If yes, you could just use the WFI
instruction directly (and it would also work if compiling the kernel
to Thumb-2 mode).

-- 
Catalin
