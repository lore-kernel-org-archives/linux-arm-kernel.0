From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Oct 2013 08:15:23 -0700
Subject: [PATCH v2 5/6] Revert "ARM: OMAP2+: Provide alias to USB PHY
 clock"
In-Reply-To: <52550180.1000506@ti.com>
References: <1381226799-29158-1-git-send-email-rogerq@ti.com>
 <1381226799-29158-6-git-send-email-rogerq@ti.com>
 <52550180.1000506@ti.com>
Message-ID: <20131009151522.GA8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [131009 00:19]:
> Hi Tony,
> 
> On 10/08/2013 01:06 PM, Roger Quadros wrote:
> > This reverts commit 741532c4a995be11815cb72d4d7a48f442a22fea.
> > 
> > The proper clock reference is provided in device tree so we
> > no longer need this.
> 
> Could you please Ack this one? I think it is best if it goes through Benoit's tree.

I could queue this into my board removal series that will be
based on Benoit's branch if that works for you. And this
also seems to depend on the omap-for-v3.13/quirk branch
that moves all the legacy pdata handling into pdata-quirks.c.

The reason for this is that we want to keep the .dts changes
completely separate from the code changes to avoid dependencies
that cause pointless merge conflicts. And the .dts files will
be moved to live in a separate repo soonish, so it's good
to be prepared for that.

Regards,

Tony
