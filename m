From: tony@atomide.com (Tony Lindgren)
Date: Sat, 19 Dec 2009 09:44:28 -0800
Subject: [PATCH 4/5] arm: Fix init_atags_procfs() to check tag->hdr.size
In-Reply-To: <20091219090332.GA28047@n2100.arm.linux.org.uk>
References: <20091219034151.26198.26570.stgit@localhost>
	<20091219034630.26198.35713.stgit@localhost>
	<20091219090332.GA28047@n2100.arm.linux.org.uk>
Message-ID: <20091219174428.GA11397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [091219 01:02]:
> On Fri, Dec 18, 2009 at 07:46:30PM -0800, Tony Lindgren wrote:
> > The tag->hdr.size cannot be larger than XXX.
> > Otherwise we can getsomething similar during boot:
> > 
> > Unable to handle kernel paging request at virtual address 61a05020
> > ...
> 
> NAK.
> 
> Why can't people get the simple ATAG setup right?  Fix the boot loader.

In this case why can't the kernel get ATAG setup right?

This only happens when kexec rebooting multiple times in a row.

Sounds like something is not memset/kzalloc'd somewhere?

Regards,

Tony
