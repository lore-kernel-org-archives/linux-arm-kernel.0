From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 24 Jan 2018 07:15:50 +0100
Subject: [PATCH] i2c: davinci: fix the cpufreq transition
In-Reply-To: <20180122144258.13627-1-brgl@bgdev.pl>
References: <20180122144258.13627-1-brgl@bgdev.pl>
Message-ID: <20180124061550.m4l3ogzpsbidajta@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 03:42:58PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> i2c_davinci_cpufreq_transition() is implemented in a way that will
> block if it ever gets called while no transfer is in progress.
> 
> Not only that, but reinit_completion() is never called for xfr_complete.
> 
> Use the fact that cpufreq uses an srcu_notifier (running in process
> context) for transitions and that the bus_lock is taken during the call
> to master_xfer() and simplify the code by removing the transfer
> completion entirely and protecting i2c_davinci_cpufreq_transition()
> with i2c_lock/unlock_adapter().
> 
> Reported-by: David Lechner <david@lechnology.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180124/c6444fb9/attachment.sig>
