From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Oct 2009 08:33:37 +0100
Subject: Ext3 is supported not well at 2.6.28 for external SD card removal
In-Reply-To: <4ADD4BE0.7050806@gmail.com>
References: <200910190759.11591.marek.vasut@gmail.com>
	<4ADBFB5B.9030200@gmail.com>
	<28376653.255741255932756974.JavaMail.coremail@bj126app18.126.com>
	<20091019150321.GE13614@n2100.arm.linux.org.uk>
	<4ADD4BE0.7050806@gmail.com>
Message-ID: <20091020073337.GA723@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2009 at 01:34:24PM +0800, Peter Chen wrote:
> The problem I found was removing SD card with ext3 without unmount, It  
> is ok at 2.6.27 and 2.6.23, but bad at 2.6.28 ( or later, I am not sure).

As has already been pointed out, removing media without unmounting it
first is highly risky - you're risking data loss in spite of ext3
being a journalling filesystem.

The other thing to think about is that with a block based journalling
filesystem, a flash-based device is going to get a higher number of
writes, and therefore will wear out (and therefore fail) quicker.  You
might be better off with some other filesystem (eg, vfat) on the SD
card.

Lastly, try reporting the problem somewhere more appropriate, such as
the ext2 maintainers/mailing list and the SD mailing list.
