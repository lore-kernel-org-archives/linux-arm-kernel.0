From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jul 2012 22:22:16 +0100
Subject: [PATCH] ARM: disable interrupt before spinning endlessly
In-Reply-To: <1341824988-18615-1-git-send-email-shawn.guo@linaro.org>
References: <1341824988-18615-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120729212216.GA11423@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 05:09:48PM +0800, Shawn Guo wrote:
> The CPU will endlessly spin at the end of machine_halt and
> machine_restart calls.  However, this will lead to a soft lockup
> warning after about 20 seconds, if CONFIG_LOCKUP_DETECTOR is enabled,
> as system timer is still alive.
> 
> Disable interrupt before going to spin endlessly, so that the lockup
> warning will never be seen.
> 
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Should this also be Cc'd to stable when it's committed?
