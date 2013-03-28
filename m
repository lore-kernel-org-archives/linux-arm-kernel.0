From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 12:49:45 -0400
Subject: [PATCH for 3.9-rc] arm: mvebu: Use local interrupt only for
 the timer 0
In-Reply-To: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
References: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130328164945.GV13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 04:09:35PM +0100, Gregory CLEMENT wrote:
> The commit 3a6f08a37 "arm: mvebu: Add support for local interrupt",
> managed the 28th first interrupts as local interrupt to match the
> hardware specification. Among these interrupts there are the Gigabits
> Ethernet ones used by the mvneta driver. Unfortunately the state of
> the percpu_irq API prevents the driver to use it.
> 
> Indeed the interrupts have to be freed when the .stop() function is
> called. As the free_percpu_irq() function don't disable the interrupt
> line, we have to do it on each CPU before calling this. The function
> disable_percpu_irq() only disable the percpu on the current CPU and
> there is no function which allows to disable a percpu irq on a given
> CPU. Waiting for the extension of the percpu_irq API, this fix allows
> to use again the mvneta driver.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/irq-armada-370-xp.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
