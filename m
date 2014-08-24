From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 24 Aug 2014 21:45:38 +0000
Subject: [RFC 2/7] bcm47xx-nvram: add new broadcom nvram driver with dt
 support
In-Reply-To: <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
 <1408915485-8078-4-git-send-email-hauke@hauke-m.de>
Message-ID: <CACna6rx_V46wAAkRFA+XnZNX80tAdWkaYrTUV5VHxLwbC6GvfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2014 21:24, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This was copied from arch/mips/bcm47xx/nvram.c and modified to interact
> with device tree. My plan is to make the MIPS bcm47xx also use this new
> driver some time later.

I don't like this.

First, you change API (_getenv call), without explanation why/if we
really need this. We decided we're very unlikely to ever find devices
with multiple (separated) NVRAMs. So what's the point of having nvram
per device?

Secondly, don't duplicate the code. If you're going to switch bcm47xx
to this new code, handle it smarter. Modify bcm47xx mode, move it to
the "misc" and re-use in bcm53xx.
