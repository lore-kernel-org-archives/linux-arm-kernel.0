From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 10:20:46 +0200
Subject: [PATCH] mfd: ab8500-core: Ignore masked out interrupts
In-Reply-To: <1363873784-27378-1-git-send-email-fabio.baltieri@linaro.org>
References: <1363873784-27378-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130409082046.GK24058@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Mar 21, 2013 at 02:49:44PM +0100, Fabio Baltieri wrote:
> AB8500 asserts LATCH bits for masked out interrupts.  This patch
> explicitly masks those out using the cached mask value to prevent
> handle_nested_irq() being called for masked IRQ on the same register as
> unmasked ones.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
> 
> Hello Samuel, Anton,
> 
> this is a small fix for the AB8500 irq generation code.  As this depends
> on Lee's patches already merged in the battery tree, this patch is based
> on Anton's repository, and should apply cleanly on it and on next.
As Lee prepared a branch for Anton and me to pull from, this patch applied
cleanly on top of mfd-next. So I took it and pushed it now.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
