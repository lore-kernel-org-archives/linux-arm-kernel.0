From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 26 Jan 2015 10:55:54 +0100
Subject: [PATCH v2 00/12] AT91 pm cleanup for 3.20
In-Reply-To: <1422265005-22937-1-git-send-email-wenyou.yang@atmel.com>
References: <1422265005-22937-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150126095554.GA18807@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Mon, Jan 26, 2015 at 05:36:45PM +0800, Wenyou Yang wrote:
> Hi Nicolas,
> 
> This version is rebased on the branch: at91-3.20-cleanup of the repository
> 	git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
> 
> It is purpose to clean up the PM code, includes the patches from Peter Rosin and Sylvain Rochet.
> 
> Since verifying the USB clock and USB PLL disabling before suspending to memory,
> it aslo depends on the following patch serials from Sylvain:
> 	[PATCHv6 0/5] USB: gadget: atmel_usba_udc: Driver improvements
> 	[PATCHv7 0/6] USB: host: Atmel OHCI and EHCI drivers improvements
> 
> Removes CONFIG_AT91_SLOW_CLOCK config item to simply the PM config,
> The suspend to standby mode uses the same sram function as the suspend to memory mode.
> Remove some unused code.
> 
> Alexandr & Sylvain, Thank you very much for so many feedbacks.
> 
> Changes in v2:
>  - Rebase on the at91-3.20-cleanup branch
>  - Recover the verify clock condition, only for suspend to memory.
>  - Collect ACK from Alexandre
>  - Add the macro for PM mode

Did you fix the slow_clock == NULL condition with the change suggested 
by Alexandre ?

Sylvain
