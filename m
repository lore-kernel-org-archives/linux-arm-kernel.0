From: davidcdueck@googlemail.com (D. Dueck)
Date: Wed, 20 May 2015 17:14:02 +0200
Subject: Problems with device tree PMC clocks and threadirqs on at91
In-Reply-To: <20150520151008.76e180db@bbrezillon>
References: <555C8117.9010508@pcs.com>
	<20150520151008.76e180db@bbrezillon>
Message-ID: <CANfhG66vxOxXB+jZYz_UhbjFpRL6ceMGJD+K5X0H_js=3U1_Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-20 15:10 GMT+02:00 Boris Brezillon <boris.brezillon@free-electrons.com>:

> That's my favorite option. But it also implies modify all other
> interrupts handler registered on irq line 1 to use IRQF_NO_THREAD (PMC,
> RTC, WDT, ...)

And those handlers currently take spin locks. So that is also not that simple.

David
