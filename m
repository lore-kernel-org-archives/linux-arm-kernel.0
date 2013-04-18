From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 11:52:46 +0100
Subject: [PATCH v3] pinctrl/pinconfig: add debug interface
In-Reply-To: <1366281314-14613-1-git-send-email-linus.walleij@stericsson.com>
References: <1366281314-14613-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130418105246.GO14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:35:14PM +0200, Linus Walleij wrote:
> +		if (map->type != dbg->map_type)
> +			continue;
> +		if (!!strcmp(map->dev_name, dbg->dev_name))

!! is pointless in this context - if() evaluates any non-zero value as
true, so there's no point making the code more complicated by trying to
convert it to a false/true value first.
