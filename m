From: tstdenis@elliptictech.com (Tom St Denis)
Date: Tue, 22 Jan 2013 07:36:13 -0500 (EST)
Subject: ARM DMA Zones (coherent memory pool)
In-Reply-To: <1706190290.100315.1358858042869.JavaMail.root@elliptictech.com>
Message-ID: <644316582.100321.1358858173237.JavaMail.root@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I was wondering if there was a proper way of instructing the init code (atomic_pool_init) for the DMA coherent subsystem to point to a fixed location instead of using alloc_pages()?

I ask because on our system (Zynq702/706 boards) DDR has a high latency (~25-30 cycles) whereas FPGA memory can be much quicker.  What I'd like to do is create a 256Kbyte memory in FPGA BRAMs and then have the CPU point at it for the DMA zone.

Is that at all possible through a simple kernel cmdline or patch?

Tom
