From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 8 Sep 2011 13:06:13 -0400 (EDT)
Subject: [PATCH v2 3/3] ARM: pxa/pj4: Port problematic pj4 support code
	to v7/Thumb-2
In-Reply-To: <1315497854-13311-4-git-send-email-dave.martin@linaro.org>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-4-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1109081304380.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Sep 2011, Dave Martin wrote:

> The iwmmxt code contains some code to implement a pseudo-ISB, but
> this is not buildable for Thumb-2.
> 
> This patch replaces the pseudo-ISB with a real one on v7 and above.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

In arch/arm/mm/Kconfig:

config CPU_PJ4
        bool
        select CPU_V7
        select ARM_THUMBEE

So this code may only be ARMv7 aware now.


Nicolas
