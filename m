From: romain.izard.pro@gmail.com (Romain Izard)
Date: Tue, 10 Oct 2017 17:00:05 +0200
Subject: [PATCH] crypto: atmel-aes - properly set IV after {en,de}crypt
In-Reply-To: <20171010161659.4117677c@bbrezillon>
References: <20171006155108.6581-1-romain.izard.pro@gmail.com>
 <20171010161659.4117677c@bbrezillon>
Message-ID: <CAGkQfmPTC60A3W0YNJKU61NweSxmfC0xaR7BoT6CG6t7BEEDrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-10 16:16 GMT+02:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> Hi Romain,
>
> May I ask why you're sending this patch to the MTD ML?
>
This is related to an issue reported by Nicolas Feignon with UBIFS and
fscrypt, which was reported on both mtd and fscrypt mailing lists.

The file names are encrypted with cts(cbc(aes)), and this patch tried to
fix a SAMA5D2 issue where the file names are not correctly encrypted
when hardware acceleration is enabled.

> While I'm here, can you have a look at this patch [1] and add you
> Reviewed-by/Tested-by?
>
> [1]http://patchwork.ozlabs.org/patch/821959/

I'll try it.

-- 
Romain Izard
