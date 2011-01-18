From: jonas.aberg@stericsson.com (Jonas Aaberg)
Date: Tue, 18 Jan 2011 09:43:46 +0100
Subject: Why call calibrate_delay() in smp.c: secondary_start_kernel()
Message-ID: <4D3552C2.3020101@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

calibrate_delay() calculates loops_per_jiffy. loops_per_jiffy is not per cpu.
Therefore I wonder why there is a calibrate_delay() call in smp.c: 
secondary_start_kernel()?

If you don't set lpj= it looks like it just takes longer time to boot
and bring a secondary cpu online.

u8500 seems to do fine without the calibrate_delay() call.

Best regards,
 Jonas Aaberg
