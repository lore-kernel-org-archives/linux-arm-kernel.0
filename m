From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Aug 2017 16:04:03 -0400 (EDT)
Subject: [PATCH 0/3] make XIP kernel .data compressed in ROM
In-Reply-To: <SG2PR06MB116536F14485B36DF66385758A9F0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170825162600.15709-1-nicolas.pitre@linaro.org>
 <SG2PR06MB1165EDDA573890B891E542CB8A9E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1708281520380.2606@knanqh.ubzr>
 <SG2PR06MB116536F14485B36DF66385758A9F0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <nycvar.YSQ.7.76.1708291602080.2606@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Aug 2017, Chris Brandt wrote:

> On Tuesday, August 29, 2017, Nicolas Pitre wrote:
> > Executive summary: our linker script is a complete mess. In your case
> > that would be partly solved by the patch that Arnd sent on Jul 28th 2017
> > titled "ARM: move __bug_table into .data for XIP_KERNEL". However the
> > XIP linker script is still broken for similar reasons.
> 
> Ya, I thought that would happen eventually. The only way I could get 
> agreement to fix existing broken XIP_KERNEL stuff was to split the linker 
> script into XIP and non-XIP. But, trying to follow every vmlinux.lds.S 
> change and checking to see if it is needed for vmlinux-xip.lds.S is a bit 
> daunting.

It is. And even in the non-XIP case with regards to changes in 
include/asm-generic/vmlinux.lds.h too.


Nicolas
