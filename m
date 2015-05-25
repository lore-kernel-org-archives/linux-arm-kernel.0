From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 25 May 2015 08:37:00 +0200
Subject: [PATCH v2] ARM: nommu: avoid deprecated source register on mov
In-Reply-To: <1432337148-9894-1-git-send-email-stefan@agner.ch>
References: <1432337148-9894-1-git-send-email-stefan@agner.ch>
Message-ID: <5562C30C.20900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 05/23/2015 01:25 AM, Stefan Agner wrote:
> In Thumb2 mode, the stack register r13 is deprecated if the
> destination register is the program counter (r15). Similar to
> head.S, head-nommu.S uses r13 to store the return address used
> after configuring the CPU's CP15 register. However, since we do
> not enable a MMU, there will be no address switch and it is
> possible to use branch with link instruction to call
> __after_proc_init.
>
> Avoid using r13 completely by using bl to call __after_proc_init
> and get rid of __secondary_switched.
>
> Beside removing unnecessary complexity, this also fixes a
> compiler warning when compiling a !MMU kernel:
> Warning: Use of r13 as a source register is deprecated when r15
> is the destination register.
>
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes in v2:
> - Load r7 outside CONFIG_ARM_MPU since its used outside later on
>
>   arch/arm/kernel/head-nommu.S | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
>
>

You can add my:
Tested-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Thanks!
Maxime
