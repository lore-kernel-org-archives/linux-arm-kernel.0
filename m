From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Oct 2014 11:17:43 -0700
Subject: [PATCH 3/3] i2c/at91: adopt pinctrl support
In-Reply-To: <1413776535-10123-4-git-send-email-wenyou.yang@atmel.com> (Wenyou
 Yang's message of "Mon, 20 Oct 2014 11:42:14 +0800")
References: <1413776535-10123-1-git-send-email-wenyou.yang@atmel.com>
 <1413776535-10123-4-git-send-email-wenyou.yang@atmel.com>
Message-ID: <7h4muyfvw8.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wenyou Yang <wenyou.yang@atmel.com> writes:

> Amend the i2c at91 pin controller to optionally take a pin control
> handle and set the state of the pins to:
>
> - "default" on boot, resume and before performing an transfer
> - "sleep" on suspend()
>
> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

This patch is a good example of why you should just have the ->suspend
function call the same function as ->runtime_suspend.

If you do that, rather than having to add the pinctrl_pm* calls bo both
system PM and runtime PM functions, you could've just added them to the
runtime PM functions.

Kevin
