From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Dec 2015 17:11:59 +0000
Subject: [PATCH v6 15/20] arm64: signal: move ilp32 and lp64 common code
 to separated file
In-Reply-To: <1450215766-14765-16-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-16-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151222171158.GD1302@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 12:42:41AM +0300, Yury Norov wrote:
> After that, it will be possible to reuse it in ILP32.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/arm64/include/asm/signal_common.h |  39 ++++++++
>  arch/arm64/kernel/Makefile             |   2 +-
>  arch/arm64/kernel/signal.c             | 154 +----------------------------
>  arch/arm64/kernel/signal_common.c      | 174 +++++++++++++++++++++++++++++++++

signal.c is always compiled, so I don't see the point of a
signal_common.c, just export the functions from signal.c
(signal32_common.c is a different story since we may not always compile
AArch32 support in).

-- 
Catalin
