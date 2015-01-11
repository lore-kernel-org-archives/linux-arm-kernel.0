From: davem@davemloft.net (David Miller)
Date: Sun, 11 Jan 2015 18:54:45 -0500 (EST)
Subject: [PATCH v2 0/7] Fix sti drivers whcih mix reg address spaces
In-Reply-To: <1420643052-4506-1-git-send-email-peter.griffin@linaro.org>
References: <1420643052-4506-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150111.185445.1288456704842706068.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed,  7 Jan 2015 15:04:05 +0000

> A V2 of this old series incorporating Arnd and Lees Feedback form v1.
> 
> Following on from Arnds comments about the picophy driver here
> https://lkml.org/lkml/2014/11/13/161, this series fixes the
> remaining upstreamed drivers for STI, which are mixing address spaces
> in the reg property. We do this in a way similar to the keystone
> and bcm7445 platforms, by having sysconfig phandle/ offset pair 
> (where only one register is required). Or phandle / integer array
> where multiple offsets in the same bank are needed).
> 
> This series breaks DT compatability! But the platform support
> is WIP and only being used by the few developers who are upstreaming
> support for it. I've made each change to the driver / dt doc / dt
> file as a single atomic commit so the kernel will remain bisectable. 
> 
> This series then also enables the picophy driver, and adds back in
> the ehci/ohci dt nodes for stih410 which make use of the picophy.

Series applied to net-next, thanks.
