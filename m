From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Dec 2015 12:12:27 -0800
Subject: [PATCH for 4.4 0/2] DT/dmaengine: edma: Convert 16bit arrays to
 32bit
In-Reply-To: <1449649091-9848-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449649091-9848-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151209201226.GB23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151209 00:19]:
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
> 
> Tony, Arnd, Vinod: Can you agree on the practicalities on how these patches are
> going to be handled? I would like to send the updated am33xx/am437x conversion
> for 4.5 based on these changes.

Yes this should go into v4.4 as discussed, otherwise it will be a mess.
For both, please feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

I suggest Vinod sets up an immutable branch against v4.4-rc1 with just these
two patches. Then it can get merged into whichever branch needs it, I
certainly will need it as most of my v4.5 branches are v4.4-rc1 or -rc2
based.

Then the immutable branch can be merged into v4.4 by Vinod or Arnd.

Regards,

Tony
