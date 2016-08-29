From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Aug 2016 13:01:20 +0200
Subject: [PATCH 1/2] arm64: dts: updates serial aliases for ls1043a rdb
 and qds boards
In-Reply-To: <1472244381-1766-2-git-send-email-stuart.yoder@nxp.com>
References: <1472244381-1766-1-git-send-email-stuart.yoder@nxp.com>
 <1472244381-1766-2-git-send-email-stuart.yoder@nxp.com>
Message-ID: <8035333.yr2FRs5mHk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 26, 2016 3:46:20 PM CEST Stuart Yoder wrote:
> -               serial0 = &lpuart0;
> -               serial1 = &lpuart1;
> -               serial2 = &lpuart2;
> -               serial3 = &lpuart3;
> -               serial4 = &lpuart4;
> -               serial5 = &lpuart5;
> +               serial0 = &duart0;
> +               serial1 = &duart1;
> +               serial2 = &duart2;
> +               serial3 = &duart3;

It looks like your board has six uarts that are all driven with the
lpuart driver, but after the change, you only list four. Should
the serial4 and serial5 aliases keep pointing at lpuart devices
so you can still drive all physical connectors?

	Arnd
