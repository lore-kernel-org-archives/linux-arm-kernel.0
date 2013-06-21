From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Jun 2013 15:41:15 -0600
Subject: [PATCH v1 08/12] input: keypad-matrix: tell GPIO pins from matrix
 lines
In-Reply-To: <1371838198-7327-9-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-9-git-send-email-gsi@denx.de>
Message-ID: <51C4C87B.3050300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> +The driver assumes that all interconnections of the matrix can potentially
> +contain a button, and will submit scan and key code events to the input
> +subsystem.  By default the keypad matrix dimenstions are automatically
> +derived from the GPIO pin specifications.  Optionally device tree
> +information can override the keypad matrix dimension data, e.g. when not
> +all of the potentially available physical connections are used to create
> +the logical keypad matrix.

Ignoring the binary encoding in the next patch, why would someone ever
define more row GPIOs that there are rows (or similarly for columns)?

On its own, I don't think this patch is needed.

Now, if you add binary encoding, I can see that you might have say 3 row
GPIOs but only say 6 rows even though there are 8 combinations of row
GPIO values. If that is the situation this patch is intended to cover,
the changes here should be introduced as part of, and only applicable
to, the binary encoding patch instead.
