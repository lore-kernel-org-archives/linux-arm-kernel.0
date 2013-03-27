From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 11:09:45 +0100
Subject: [PATCH v2 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <201303271000.47614.arnd@arndb.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303270929.45733.arnd@arndb.de>
 <CAHTX3d+9ST0X7x5hx5aLV2YMFUhPcmQg-VThX81vwk64WXj-eQ@mail.gmail.com>
 <201303271000.47614.arnd@arndb.de>
Message-ID: <CAHTX3d+J370kD=1Eeuo_srKCngFizuYV=HtmgYsHfXvG80O01w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/27 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 27 March 2013, Michal Simek wrote:
>> FYI: I have looked at some code and I saw that Rob is using scu_base_addr
>> in highbank. And then pointing to it in cpuidle-calxeda.c.
>
> Yes, the point is that it works as long as only one person uses that
> identifier, so we should either not use it at all, or have a single
> global definition shared by all ARM platforms.

yep.

>> Moving everything to one file is probably impossible.
>>
>> And in connection to symbols/functions/variables. It means that all
>> specific soc functions in mach
>> should also use specific prefix for everything.
>
> That is a good rule, although for static symbols it is not a bug
> if they don't have a prefix.

ok. Let me check all my patches and Add there zynq_ prefix everywhere.


BTW: Have you added to zero day testing system arm multi platform
or is there any arm multi platform config which developer should run
to be sure that armv7 code can be compiled for armv6 and also
that there is no problem with symbols?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
