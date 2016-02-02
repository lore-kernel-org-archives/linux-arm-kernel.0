From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 1 Feb 2016 21:55:56 -0800
Subject: [PATCH LINUX 0/6] Second part of xuartps fixes
In-Reply-To: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20160202055556.GD4215@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping? Any comments?

	Thanks,
	S?ren

On Mon, 2016-01-11 at 17:41:35 -0800, Soren Brinkmann wrote:
> Hi,
> 
> this is the second part of fixes for xuartps that evolved from this
> series: https://lkml.org/lkml/2015/12/26/26.
> 
> This series, obviously, depends on the patches mentioned above. It
> includes several minor improvements and refactoring and the refactoring
> of the IRQ management, which prevents lock ups that could happen when
> RX-related IRQs fired while the receiver was disabled.
> 
> 	Thanks,
> 	S?ren
> 
> S?ren Brinkmann (6):
>   tty: xuartps: Move request_irq to after setting up the HW
>   tty: xuartps: Refactor IRQ handling
>   tty: xuartps: Cleanup: Reformat if-else
>   tty: xuartps: Improve sysrq handling
>   tty: xuartps: Remove '_OFFSET' suffix from #defines
>   tty: xuartps: Consolidate TX handling
> 
>  drivers/tty/serial/xilinx_uartps.c | 460 +++++++++++++++++--------------------
>  1 file changed, 216 insertions(+), 244 deletions(-)
> 
> -- 
> 2.7.0.3.g497ea1e
> 
