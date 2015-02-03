From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Feb 2015 13:57:17 +0100
Subject: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
In-Reply-To: <54D0B2FA.9080600@arm.com>
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
 <4324891.mqG6Yyfi6J@wuerfel> <54D0B2FA.9080600@arm.com>
Message-ID: <47577254.MGNlDcIDBf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 February 2015 11:37:30 Marc Zyngier wrote:
> Side question: In the probe-only case, should we still allow this write
> to happen?

No, my understanding is that PCI_PROBE_ONLY precisely means that we
do not modify the config space and instead trust what is there to
be sensible.

	Arnd
