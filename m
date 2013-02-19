From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 19 Feb 2013 15:30:01 +0000 (UTC)
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod
 dependency
In-Reply-To: <20130214224710.GF11362@atomide.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
 <20130214224710.GF11362@atomide.com>
Message-ID: <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 14 Feb 2013, Tony Lindgren wrote:

> The other option could be to allow custom ioremap function pointers 
> based on address range in __arm_ioremap_pfn_caller() the same way as
> the SoC specific static mappings are allowed. That would require adding
> a function pointer to struct map_desc.
> 
> Maybe that would do the trick?

That sounds fine to me too.

To me it makes sense to eventually handle the I/O mappings automatically 
from data in the DT -- hence the association with a bus device, which 
should be present in DT data.


- Paul
