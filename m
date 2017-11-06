From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Mon, 6 Nov 2017 17:45:50 +0200
Subject: [PATCH 2/2] crypto: atmel-aes - Reset the controller before each
 use
In-Reply-To: <20171031152524.25216-3-romain.izard.pro@gmail.com>
References: <20171031152524.25216-1-romain.izard.pro@gmail.com>
 <20171031152524.25216-3-romain.izard.pro@gmail.com>
Message-ID: <ff2356ef-2c11-18e5-6da2-654b1d77280c@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Romain,

On 10/31/2017 05:25 PM, Romain Izard wrote:
> When using the rfc4543(gcm(aes))) mode, the registers of the hardware
> engine are not empty after use. If the engine is not reset before its
> next use, the following results will be invalid.
> 
> Always reset the hardware engine.

Thanks for the fix! I could reproduce the issue only when running
rfc4543(gcm(aes))) and then, immediately after, ecb(aes).

Have you encountered this bug with other combination of algorithms?

I'm trying to isolate the bug so that we can have a more fine-grained
fix.

Cheers,
ta
