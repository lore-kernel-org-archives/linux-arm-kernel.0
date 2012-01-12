From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jan 2012 23:28:27 +0000
Subject: [PATCH] versatile: don't generate a duplicate IRQ domain
In-Reply-To: <20120112232611.GB14007@page>
References: <1325867997-20761-1-git-send-email-jamie@jamieiles.com>
 <20120112203756.GM1068@n2100.arm.linux.org.uk> <20120112215801.GB13991@page>
 <20120112221454.GN1068@n2100.arm.linux.org.uk>
 <CACxGe6tz8UZEEKLcNKyqRvrjzX8jJ-qyrPZwOfgjS0+djaY1mw@mail.gmail.com>
 <20120112231811.GO1068@n2100.arm.linux.org.uk> <20120112232611.GB14007@page>
Message-ID: <20120112232827.GP1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 11:26:11PM +0000, Jamie Iles wrote:
> No, because:
> 
> 	vic_init()
> 	  __vic_init() -> with NULL np pointer
> 	    vic_register()
> 	
> So we won't have the device_node for the VIC.  I think I really need to 
> convert the versatile stuff over to the full of_irq_init() method of 
> probing, which isn't as bad as I thought as everything is populated from 
> the DT there but it looked like it could be registered statically too 
> from versatile_init().  I'll try and get everything going from the DT 
> now.

Won't this make Versatile a DT-only platform?
