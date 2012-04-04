From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 4 Apr 2012 09:53:08 -0400
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <20120404090754.GR24211@n2100.arm.linux.org.uk>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLpim2TCMO5nDVNe0bdm9ZQ+czUWNpxxWugDzrHO6aYVAQ@mail.gmail.com>
 <CAOMZO5A-+tcz6ewTykXL33opRVP9U4o7Ltdkbr7LLqWMBQczSQ@mail.gmail.com>
 <201204030819.48798.arnd@arndb.de> <4F7AFF61.3070803@windriver.com>
 <20120404090754.GR24211@n2100.arm.linux.org.uk>
Message-ID: <4F7C5244.4040700@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-04-04 05:07 AM, Russell King - ARM Linux wrote:
> On Tue, Apr 03, 2012 at 09:47:13AM -0400, Paul Gortmaker wrote:
>> As a side note, the fact that struct pci_sys_data is ARM specific
>> does make one think it would be nice if the name somehow did
>> reflect that...  wonder if it is worth changing.  Anyway, that is
>> a separate topic.
> 
> And what's wrong with the existing name when it's limited to only
> ARM specific files?

Just in the context of Arnd's original comment, he thought I
screwed up by feeding an ARM specific struct into generic
PCI code, because I wasn't aware it was ARM specific.

That wasn't the case, but he's right that something like that
could happen  A minor nit, sure, but if it was something like
pci_arm_data, the name itself would convey it was arm specific,
even in reduced context scenarios (like grep output etc).

P.
