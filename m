From: wmb@firmworks.com (Mitch Bradley)
Date: Fri, 06 Jul 2012 14:24:56 -1000
Subject: Where to put a large bootloader-supplied device tree on ARM ?
In-Reply-To: <20120706210009.GC11470@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <201207051454.24475.arnd@arndb.de> <20120705161600.GA28860@lunn.ch>
 <201207062008.23952.arnd@arndb.de> <20120706210009.GC11470@lunn.ch>
Message-ID: <4FF781D8.3040206@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm passing a flatted device tree from OLPC's bootloader (which
is a full Open Firmware implementation) to the kernel.  If I
put the FDT at the "traditional" address 0x100, bad things
happen when the DT is larger than 16K.  The FDT extends past
the 0x4000 boundary and gets overwritten by the early page tables
which are written at that address.

I have found various places in memory where I can place it
without it being overwritten, and things work, but that seems
dodgy and likely to break randomly.

Has there been any discussion about where large-ish FDT images
should be located?
