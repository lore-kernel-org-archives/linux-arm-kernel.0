From: mbizon@freebox.fr (Maxime Bizon)
Date: Fri, 08 Mar 2013 16:59:50 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307230516.GA28975@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307222004.GA2450@localhost>
 <20130307230516.GA28975@obsidianresearch.com>
Message-ID: <1362758390.25161.17.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-07 at 16:05 -0700, Jason Gunthorpe wrote:
> 
> BTW, I've made the same basic choice on our Kirkwood systems. The NAND
> timing pameters are set by the bootloader and the kernel doesn't touch
> them. The bootloader knows which flash chip is placed on the board so
> only it knows the correct timing parameters. There is not any reason
> to communicate them to the kernel. 

since you can probe the chip ONFI timings, why are you doing that ?

on a general standpoint, why would you ever want to run with whatever
the bootloader left in registers if you have full knowledge to reprogram
them in the kernel ?

from a testability point this is horrible,

users get the classic answer to bug reports, "the problem must be coming
from your bootloader, try upgrading it"

the 'B' in BIOS stands for buggy

-- 
Maxime
