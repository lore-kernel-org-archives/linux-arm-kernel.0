From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 15:51:26 -0600
Subject: [PATCH 4/4] clocksource: armada-370-xp: Fix clock input in
 devicetree binding
In-Reply-To: <1376929695-10026-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376929695-10026-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5212935E.7030703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 10:28 AM, Ezequiel Garcia wrote:
> This commit specifies the clock inputs available for the Armada XP
> timer: namely the 'nbclk' (L2/coherency fabric) and the 'refclk'
> (25 MHz fixed-clock).

> diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt

> -- clocks: clock driving the timer hardware, only required for
> -  "marvell,armada-370-timer";
> +- clocks: clock driving the timer hardware.

The valid (and required?) entries for clock-names need to be documented
here in the list of properties, not just show up in the example below.

Didn't I see some other conflicting patch for this file just the other
day which was doing exactly that? Maybe I'm getting different patches
confused...
