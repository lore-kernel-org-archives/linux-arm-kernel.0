From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 10:00:47 +0000
Subject: [PATCH v2 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <CAHTX3d+9ST0X7x5hx5aLV2YMFUhPcmQg-VThX81vwk64WXj-eQ@mail.gmail.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303270929.45733.arnd@arndb.de>
 <CAHTX3d+9ST0X7x5hx5aLV2YMFUhPcmQg-VThX81vwk64WXj-eQ@mail.gmail.com>
Message-ID: <201303271000.47614.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Michal Simek wrote:
> FYI: I have looked at some code and I saw that Rob is using scu_base_addr
> in highbank. And then pointing to it in cpuidle-calxeda.c.

Yes, the point is that it works as long as only one person uses that
identifier, so we should either not use it at all, or have a single
global definition shared by all ARM platforms.

> Moving everything to one file is probably impossible.
> 
> And in connection to symbols/functions/variables. It means that all
> specific soc functions in mach
> should also use specific prefix for everything.

That is a good rule, although for static symbols it is not a bug
if they don't have a prefix.

	Arnd
