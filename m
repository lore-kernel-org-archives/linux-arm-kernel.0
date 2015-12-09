From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 10:00:13 +0100
Subject: [PATCH for 4.4 0/2] DT/dmaengine: edma: Convert 16bit arrays to
 32bit
In-Reply-To: <1449649091-9848-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449649091-9848-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <7691711.qMGLSkELz4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 December 2015 10:18:09 Peter Ujfalusi wrote:
> Hi,
> 
> Based on the discussion regarding to (convert am33xx to use the new eDMA
> bindings):
> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg122117.html
> 
> This two patch will convert the new eDMA binding to not use 16bit arrays for
> memcpy channel selection and for marking slots reserved.
> The '/bits/ 16' seams to be causing confusion so it is probably better to just
> use standard type for the arrays.
> 
> The new bindings for the eDMA is introduced for 4.4 and we do not have users of
> it, which means that we can still change it w/o the risk of breaking anything
> and we do not need to maintain the compatibility with 16bit arrays.
> 
> The changes in the eDMA driver is local to the DT parsing and should not
> conflict with other changes (like the filter function mapping support). Hrm,
> there might be trivial conflict in the include/linux/platform_data/edma.h with
> the "dmaengine 'universal' API".

Both patches

Acked-by: Arnd Bergmann <arnd@arndb.de>

> Tony, Arnd, Vinod: Can you agree on the practicalities on how these patches are
> going to be handled? I would like to send the updated am33xx/am437x conversion
> for 4.5 based on these changes.

I'd suggest you send a pull request with these two patches on top of 4.4-rc1,
and then either Vinod or I send it to Linus, and you base your other changes
on top of the same branch.

I think Vinod's tree is slightly more fitting for the 4.4 merge, but if he
prefers me to take them instead, I will.

	Arnd
