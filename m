From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 00:26:54 +0200
Subject: [GIT PULL 1/4] Broadcom soc changes for 4.9
In-Reply-To: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
References: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <5842668.ozaicnlSdQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 6, 2016 6:59:15 PM CEST Florian Fainelli wrote:
> This pull request contains Broadcom ARM-based SoC changes for 4.9, please pull
> the following:
> 
> - Rafal adds preliminary support for the new BCM53573 Wi-Fi SoC based on a
>   single core Cortex A7 and re-using a bunch of iProc peripherals
> 
> - Florian adds support for earlyprintk on Broadcom STB/CM ARM-based chips by
>   reading the chip family_id value from a known location and deriving the UART
>   based address
> 

Pulled into next/soc, thanks!

Regarding the debug_ll code, having the autodetection is nice, but note
that the fashionable way to handle this now is to use earlycon instead
of earlyprintk, getting all the settings from DT, so you shouldn't
really need this any more unless you are debugging extremely early
startup code or the decompressor.

	Arnd
