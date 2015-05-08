From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 08 May 2015 12:09:57 +0200
Subject: [PATCH 02/12] clocksource: sti: Provide support for the ST LPC
 Clocksource IP
In-Reply-To: <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
Message-ID: <1431079797.13593.28.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig

> +config CLKSRC_ST_LPC
> +	bool
> +	depends on ARCH_STI

By itself this does nothing. You can't set this symbol to 'y', even if
ARCH_STI is 'y', right? Of course, ARCH_STI will select this symbol (see
11/12) otherwise it would be inert. But as ARCH_STI selects
CLKSRC_ST_LPC I'd say this dependency isn't actually needed.

Are other selects of CLKSRC_ST_LPC expected to be added in the future?
If not, CLKSRC_ST_LPC should operate in lockstep with ARCH_STI. In that
case you might as well not bother with CLKSRC_ST_LPC and use ARCH_STI
directly. (But that forces you to move the select statement below into
the ARCH_STI entry, which might be ugly.)

> +	select CLKSRC_OF if OF
> +	help
> +	  Enable this option to use the Low Power controller timer
> +	  as clocksource.

(Please add an empty line.)

>  endmenu

Thanks,


Paul Bolle
