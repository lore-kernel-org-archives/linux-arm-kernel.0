From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2016 14:53:18 +0000
Subject: [PATCH] [RFC] ARM: keystone: possibly fix big-endian kernels
In-Reply-To: <1456238609-962461-1-git-send-email-arnd@arndb.de>
References: <1456238609-962461-1-git-send-email-arnd@arndb.de>
Message-ID: <20160223145318.GK19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 03:43:21PM +0100, Arnd Bergmann wrote:
> While discussing a regressing in the netcp driver, I wondered
> whether Keystone can work with a big-endian kernel, and noticed
> that we don't switch endianess when we enter the kernel on the
> secondary CPU, or when we call into smc.

NAK.  Sorry Arnd, you're worringly wrong on this.

secondary_startup will do the setend if necessary, there's no need
to do this kind of junk in each and every platform.  It's been this
way since:

commit 97bcb0fea590d3d704f985bec08f342d28992634
Author: Ben Dooks <ben.dooks@codethink.co.uk>
Date:   Fri Feb 1 09:40:42 2013 +0000

So, I hope you've not been telling platform folk to do this.  Please
audit the arm-soc code to make sure, thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
