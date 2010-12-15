From: kernelccrazy@gmail.com (y bhanu)
Date: Wed, 15 Dec 2010 14:54:57 -0800
Subject: dma_cache_sync replacement call
Message-ID: <AANLkTi=p3eaVKUNvxLCThhDC534j_SX+TUtxYgGfu40Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I am porting a Linux wireless driver from MIPS to ARM (ixp4xx).

As dma_cache_sync() is not implemented for ARM ,I get some nasty errors:
I am not sure whats the replacement for this deprecated call under ARM.

can  anyone help figure out what use instread of dma_cache_sync() &
dma_cache_wback_inv() calls?

Missing dma_cache_sync & dma_cache_wback_inv under arch/arm/*

Erorr log
~~~~~~~
if_bus.c:32: error: implicit declaration of function 'dma_cache_sync'
if_bus.c: In function 'bus_map_single':
if_bus.c:49: error: implicit declaration of function 'dma_cache_wback_inv'
if_bus.o] Error 1
make[8]: *** [th_dev] Error 2

Thanks,
Bhan
