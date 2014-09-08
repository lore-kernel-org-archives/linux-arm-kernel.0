From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 14:20:21 +0200
Subject: [PATCH 5/7 v6] ARM: l2c: parse 'cache-size' and 'cache-sets'
 properties
In-Reply-To: <1410176286-32533-6-git-send-email-linus.walleij@linaro.org>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
 <1410176286-32533-6-git-send-email-linus.walleij@linaro.org>
Message-ID: <4685530.jbNLD4yaA8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 13:38:04 Linus Walleij wrote:
> +       of_property_read_u32(np, "cache-size", &size);
> +       of_property_read_u32(np, "cache-sets", &sets);
> +
> +       if (!size || !sets)
> +               return;
> +
> +       way_size = size / sets;

Going back to this one: Isn't (size / sets) the set-size rather
than the way-size?

After we discussed this on IRC, I had expected a calculation like

	set_size = size / sets;
	ways = set_size / line_size;
	way_size = size / ways;

	Arnd
