From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 29 Oct 2014 22:29:01 +0100
Subject: [PATCH v2 1/4] pinctrl: rockchip: Set wake_enabled
In-Reply-To: <1413913655-22351-1-git-send-email-dianders@chromium.org>
References: <1413913655-22351-1-git-send-email-dianders@chromium.org>
Message-ID: <1922514.nxgPA75ufi@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Oktober 2014, 10:47:32 schrieb Doug Anderson:
> The rockchip pinctrl driver uses irq_gc_set_wake() but doesn't setup
> the .wake_enabled member.  That means that we can never actually use a
> pin for wakeup.  When "irq_set_irq_wake()" tries to call through it
> will always get a failure from set_irq_wake_real() and will then set
> wake_depth to 0.  Assuming you can resume you'll later get an error
> message about "Unbalanced IRQ x wake disable".
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Chris Zhong <zyw@rock-chips.com>

I've added all 4 patches to a v3.19-pinctrl/next branch.

As I'm still looking at the suspend pinctrl changes I'll wait for this before 
I send this to LinusW.


Heiko
