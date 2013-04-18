From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 13:07:38 +0200
Subject: [PATCH 24/32] dmaengine: ste_dma40: Supply full Device Tree
 parsing support
In-Reply-To: <1366279934-30761-25-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-25-git-send-email-lee.jones@linaro.org>
Message-ID: <201304181307.39002.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> +               dma-channels = <0>; /* Zero means read from H/W. */

One more thing: I would not make this a magic value. Better make the property
optional and require it to be correct if present and autodetected if absent.

	Arnd
