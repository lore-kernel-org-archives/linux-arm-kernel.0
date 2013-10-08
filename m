From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 08 Oct 2013 09:27:49 +0200
Subject: [PATCH 0/2] additional vexpress-tc2 big endian fixes
In-Reply-To: <1381207040-1623-1-git-send-email-victor.kamensky@linaro.org>
References: <1381207040-1623-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <5253B3F5.1020704@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/13 06:37, Victor Kamensky wrote:
> Hi Ben,
>
> Here are couple more big endian related fixes. We run into these
> with vexpress TC2 board, when CONFIG_MCPM and CONFIG_ARM_CCI configs
> are enabled. Big endian image fails to boot. With fixes BE TC2
> boots and it sees all 5 cores (2xA15, 3xA7).
>
> These were tested with vexpress TC2 on latest linux-linaro
> branch (include BE patch series) and it was tested on very
> recent rmk/fixes branch along with BE series on top of it.
>
> Thanks,
> Victor
>
> Victor Kamensky (2):
>    ARM: mcpm: fix big endian issue in mcpm startup code
>    ARM: cci: driver need big endian fixes in asm code
>
>   arch/arm/common/mcpm_head.S | 2 ++
>   drivers/bus/arm-cci.c       | 6 ++++++
>   2 files changed, 8 insertions(+)

Thanks, anyone any objections if these go into my 312-rc4 branch?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
