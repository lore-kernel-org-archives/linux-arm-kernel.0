From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Tue, 30 Oct 2018 14:00:56 +0100
Subject: [BUG] MVPP2 driver exploding in presence of a tap interface
In-Reply-To: <CAPv3WKfn6QFPnNjpY2dU5-OHftObzdcrHopX8Y9w5h37Zd4BNw@mail.gmail.com>
References: <6355174d-4ab6-595d-17db-311bce607aef@arm.com>
 <20181030105015.GB3407@kwain>
 <7bd72963-1e7c-5175-ba88-fc020d786f0c@arm.com>
 <CAPv3WKfn6QFPnNjpY2dU5-OHftObzdcrHopX8Y9w5h37Zd4BNw@mail.gmail.com>
Message-ID: <20181030140056.2fc69efc@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marcin,

Thanks for the feedback.

On Tue, 30 Oct 2018 13:37:37 +0100, Marcin Wojtas wrote:

> You use _really_ archaic firmware, the bug you see is 99% caused by a
> bug already fixed long time ago (cleanup all PP2 BM pools correctly
> during exit boot services). Please grab the latest release:
> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/wiki/files/flash-image-18.09.4.bin
> and let know if you observe any further issues with vanilla kernel.

Even if this was a bug in the UEFI firmware, shouldn't the kernel be
independent from that, by doing a proper reset/reinit of the HW ?

I.e, isn't the firmware fix papering over a bug that should be fixed in
Linux mvpp2 driver anyway ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
