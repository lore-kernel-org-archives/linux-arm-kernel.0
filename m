From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Apr 2015 16:21:18 +0200
Subject: [PATCH 1/6] ARM: lpc18xx: add basic support for NXP LPC18xx/43xx
 SoCs
In-Reply-To: <1427923243-26296-2-git-send-email-manabian@gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
 <1427923243-26296-2-git-send-email-manabian@gmail.com>
Message-ID: <2687696.KedyLfyrHp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 April 2015 23:20:38 Joachim Eastwood wrote:
> +static const char *const lpc18xx_43xx_compat[] __initconst = {
> +       "ea,lpc4357-developers-kit",
> +       NULL
> 

I don't see 'ea' in Documentation/devicetree/bindings/vendor-prefixes.txt,
can you add a patch for that?

It's probably better to make the string we match against the most
generic one here, so we don't have to update the list for every
new dts file that gets added.

	Arnd
