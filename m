From: davem@davemloft.net (David Miller)
Date: Tue, 11 Aug 2015 13:49:11 -0700 (PDT)
Subject: [PATCH v2 0/2] net: thunder: Add ACPI support.
In-Reply-To: <55CA5567.9010002@caviumnetworks.com>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
 <20150811.114908.1384923604512568161.davem@davemloft.net>
 <55CA5567.9010002@caviumnetworks.com>
Message-ID: <20150811.134911.568429332024299359.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <ddaney@caviumnetworks.com>
Date: Tue, 11 Aug 2015 13:04:55 -0700

> You seem to be recommending precedence for OF.  It should be
> consistent across all drivers/sub-systems, so do you really think
> that OF before ACPI is the way to go?

I just think it's more hackish to test acpi_disabled than to
simply see if the matching OF node even exists.

If ACPI is enabled, no OF node will be found.

It could just be my preference for such things.

I really wish it just fell out from the probing method, but
we're using PCI for that.
