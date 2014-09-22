From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 22 Sep 2014 12:05:22 +0100
Subject: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
In-Reply-To: <20140919210313.GH19374@google.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
 <20140919210313.GH19374@google.com>
Message-ID: <20140922110522.GK1994@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 10:03:13PM +0100, Bjorn Helgaas wrote:
> On Thu, Sep 18, 2014 at 02:30:22AM +0100, Liviu Dudau wrote:
> > Add of_pci_get_domain_nr() to retrieve the PCI domain number
> > of a given device from DT. If the information is not present,
> > the function can be requested to allocate a new domain number.
> 
> Is of_pci_get_domain_nr() used somewhere?  If the use is in some future
> series, please mention it explicitly.  I'm just trying to avoid merging
> unused code.

It is used in the arm64 specific patch that I have dropped out of my
pull request. After discussions with Catalin I will add the patch back
into the tree that you've pulled from as he is OK with your tree carrying
the whole package.

I need to ask for some guidance here: for addressing some of your comments
and Rob's I can add more patches in my v11 branch and you can pull them
when you think they are ready. But one of your comments was requesting
splitting a patch into two blocks - one that moves of_pci_range_to_resource()
into drivers/of/address.c and one that fixes it's behaviour - and I don't
know how you would like that handled. Should I revert the original patch
and add the new ones, or should I rebase the whole series into a different
branch that you can pull from?

Best regards,
Liviu

> 
> Bjorn
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
