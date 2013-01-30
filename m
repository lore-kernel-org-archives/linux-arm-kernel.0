From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 30 Jan 2013 09:17:28 +0100
Subject: [PATCH v3 3/3] leds: leds-pwm: Defer led_pwm_set() if PWM can
 sleep
In-Reply-To: <1359381659-24454-4-git-send-email-florian.vaussard@epfl.ch>
References: <1359381659-24454-1-git-send-email-florian.vaussard@epfl.ch>
 <1359381659-24454-4-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130130081728.GC13568@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 03:00:59PM +0100, Florian Vaussard wrote:
> Call to led_pwm_set() can happen inside atomic context, like triggers.
> If the PWM call can sleep, defer using a worker.
> 
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  drivers/leds/leds-pwm.c |   50 +++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 42 insertions(+), 8 deletions(-)

Bryan, I assume that you'll be taking this? It doesn't apply cleanly to
my tree, probably because of Peter's recent changes that you took
through your tree and Florian based his patches on top of that. The
conflict resolution should be trivial, though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130130/68110b04/attachment.sig>
