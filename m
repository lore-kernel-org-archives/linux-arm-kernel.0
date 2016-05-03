From: robh@kernel.org (Rob Herring)
Date: Tue, 3 May 2016 11:53:57 -0500
Subject: [PATCH v3 3/3] leds: gpio: Support the "panic-indicator"
 firmware property
In-Reply-To: <1461881020-13964-4-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1461881020-13964-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1461881020-13964-4-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <20160503165357.GA10505@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 07:03:40PM -0300, Ezequiel Garcia wrote:
> Calling a GPIO LEDs is quite likely to work even if the kernel
> has paniced, so they are ideal to blink in this situation.
> This commit adds support for the new "panic-indicator"
> firmware property, allowing to mark a given LED to blink on
> a kernel panic.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  Documentation/devicetree/bindings/leds/leds-gpio.txt | 2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/leds/leds-gpio.c                             | 4 ++++
>  include/linux/leds.h                                 | 1 +
>  3 files changed, 7 insertions(+)
