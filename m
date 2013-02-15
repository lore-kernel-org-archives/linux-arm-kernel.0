From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Feb 2013 18:56:47 +0530
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130215101610.GR17852@n2100.arm.linux.org.uk>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk>
Message-ID: <511E3797.2070802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Friday 15 February 2013 03:46 PM, Russell King - ARM Linux wrote:
> On Thu, Feb 14, 2013 at 08:47:53PM +0000, Paul Walmsley wrote:

[..]

>
>> So instead of something bus-specific like that, a better way would be to
>> use something like:
>>
>> va = dev->bus->ioremap( ... );
>> va = dev->bus->iounmap( ... );
>
> No.  ioremap() is already generic.  We don't need additional layers of
> indirection per bus type.
>
Whats your view on use of arch_ioremap_caller() hook ? This can allow
us to avoid the dual ioremap() issue discussed here if the hook
maintains the list of mapped ios.

I was even thinking of having such intelligence within the core
ioremap code but thought that might be too invasive.

Regards,
Santosh
