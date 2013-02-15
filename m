From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Feb 2013 19:01:47 +0530
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130215132726.GT17852@n2100.arm.linux.org.uk>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk> <511E3797.2070802@ti.com>
 <20130215132726.GT17852@n2100.arm.linux.org.uk>
Message-ID: <511E38C3.7080404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013 06:57 PM, Russell King - ARM Linux wrote:
> On Fri, Feb 15, 2013 at 06:56:47PM +0530, Santosh Shilimkar wrote:
>> Whats your view on use of arch_ioremap_caller() hook ? This can allow
>> us to avoid the dual ioremap() issue discussed here if the hook
>> maintains the list of mapped ios.
>>
>> I was even thinking of having such intelligence within the core
>> ioremap code but thought that might be too invasive.
>
> Why do you even need it?  There's no problem with ioremapping the same
> space multiple times (you end up with multiple mappings but that
> shouldn't be a problem, except for the additional space used.)
>
It just waste of iospace and Tony insisted to have just single ioremap()
hence all this discussion

regards
Santosh
