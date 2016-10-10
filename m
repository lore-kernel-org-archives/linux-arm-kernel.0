From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Oct 2016 16:13:45 +0200
Subject: [PATCH 3/4] base: soc: Check for NULL SoC device attributes
In-Reply-To: <1475572167-29581-4-git-send-email-geert+renesas@glider.be>
References: <1475572167-29581-1-git-send-email-geert+renesas@glider.be>
 <1475572167-29581-4-git-send-email-geert+renesas@glider.be>
Message-ID: <1521283.2YYXpcZaoN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 4, 2016 11:09:26 AM CEST Geert Uytterhoeven wrote:
> If soc_device_match() is used to check the value of a specific
> attribute that is not present for the current SoC, the kernel crashes
> with a NULL pointer dereference.
> 
> Fix this by explicitly checking for the absence of a needed property,
> and considering this a non-match.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
