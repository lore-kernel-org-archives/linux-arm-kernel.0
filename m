From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 22 Nov 2017 08:42:35 -0600
Subject: [PATCH 30/30] PCI: remove pci_get_bus_and_slot() function
In-Reply-To: <20171122075124.GA26583@kroah.com>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
 <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
 <6a78596e-720a-80a2-9d96-dcc79a32f677@codeaurora.org>
 <25ec431a-2c1b-d352-f9ef-c663864664b6@codeaurora.org>
 <20171122075124.GA26583@kroah.com>
Message-ID: <a443e88e-3abd-0dab-2828-9753326e8d5d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/17 1:51 AM, Greg KH wrote:
> Ick, no, why?  What is wrong with removing this function as is?  Don't
> mark something as __depreciated if there are no in-kernel users, just
> delete it and move on.
> 
> If you have out-of-tree drivers, then yes, they can make a wrapper for
> this function like this if they really feel the need, or they can get
> their code merged:)

Sorry, I guess I should have been clearer.  My suggestion was to fix 
some of the drivers where the domain can be determined, and for the 
rest, just mark the old function as deprecated.

If that's still a terrible idea, well, okay.  I'm just unsure that 
simply hard-coding a 0 for the domain for some drivers is really a 
solution.  Don't we really want all drivers to properly support all domains?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
