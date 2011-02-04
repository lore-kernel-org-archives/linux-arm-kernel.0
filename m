From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Feb 2011 19:13:08 -0800
Subject: [PATCH 0/2] Allow using machine ID for DEBUG_LL macros
In-Reply-To: <alpine.LFD.2.00.1102032057070.12104@xanadu.home>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
	<alpine.LFD.2.00.1102032057070.12104@xanadu.home>
Message-ID: <20110204031307.GS3322@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110203 18:01]:
> On Thu, 3 Feb 2011, Tony Lindgren wrote:
> 
> > Hi all,
> > 
> > Here are two patches that allow using machine ID for DEBUG_LL
> > macros by adding a new macro inituart.
> 
> This won't work with the device tree support as the machine ID is then 
> replaced with a catch-it-all-with-dt-support machine ID.

Hmm, maybe for device tree we could only have it initialized later
on by setting up custom early_printk in early_printk.c based on the
device tree data or machine ID?

It won't work very early then though.. If we want it to work early
we could allocate some fixed memory chunk for addruart etc functions
for which the bootloader just passes addresses.

Tony
