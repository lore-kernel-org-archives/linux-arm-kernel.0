From: khilman@ti.com (Kevin Hilman)
Date: Fri, 18 Nov 2011 11:02:55 -0800
Subject: [PATCHv9 07/18] mfd: omap-prm: added suspend prepare and complete
 callbacks
In-Reply-To: <1316781986-30642-8-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Fri, 23 Sep 2011 15:46:15 +0300")
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
 <1316781986-30642-8-git-send-email-t-kristo@ti.com>
Message-ID: <87d3cpxnhc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> These are needed because runtime PM is disabled during suspend, and
> it is bad if we get interrupts from the PRCM chain handler during it.
> Now, PRCM interrupt forwarding is disabled until the suspend->complete,
> which makes sure that all the needed drivers are up.

Just to clarify...  based on reading the patch, the wakeup and PRCM
interrupts themselves still happen (and are saved). They are just not
dispatched to the drivers until ->complete().

I think the changelog should be a bit clearer about that.

Thanks,

Kevin
