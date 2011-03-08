From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Mar 2011 09:36:57 +0000
Subject: Amba CLCD register definitions
In-Reply-To: <4D75EF86.8020103@linuxtv.org>
References: <4D75EF86.8020103@linuxtv.org>
Message-ID: <20110308093657.GA25874@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2011 at 09:57:42AM +0100, Michael Hunold wrote:
> While working on that, I came across the following oddity. The Amba CLCD
> driver supports both PL110 and PL111 primecells.
> 
> The PL110 register summary can be found here:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0161e/I904416.html

PL110 is rather screwed up because there's various revisions and
implementations within ARM which have different register layouts and
register namings.  Eg, you'll find Versatile has a PL110 fitted but has
the PL111 register layout with IENB and CNTL swapped.

I don't remember the ancestry of the names, but DDI0161D only gives the
registers long names.  They probably came from an implementation provided
by ARM in years gone by, which would've been created by those doing
platform support back in the early days.

It's only with DDI0161E that they've been given short names.

I don't think we should change the names just because someone decided to
add such things to the latest revision of documentation.
