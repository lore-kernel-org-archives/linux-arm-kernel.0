From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 12 Sep 2013 16:13:29 +0530
Subject: [PATCH] arm: mach-davinci: mark __maybe_unused struct
In-Reply-To: <1378317646-21262-1-git-send-email-computersforpeace@gmail.com>
References: <1378317646-21262-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <52319AD1.9020305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 September 2013 11:30 PM, Brian Norris wrote:
> If neither CONFIG_SND_DM365_AIC3X_CODEC nor CONFIG_SND_DM365_VOICE_CODEC
> are defined, we may get warnings like:
> 
>     arch/arm/mach-davinci/board-dm365-evm.c:179:33: warning: 'dm365_evm_snd_data' defined but not used [-Wunused-variable]
> 
> To fix this, just mark the struct as __maybe_unused.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Thanks, will queue this for -rc cycle. For future, please note that
subject line of DaVinci patches need to be prefixed "ARM: davinci: ".
Also, the subject should highlight the answer to "Why?" rather than
"How?". So, while committing I changed the headline to:

ARM: davinci: dm365 evm: fix unused variable warning

Thanks,
Sekhar
