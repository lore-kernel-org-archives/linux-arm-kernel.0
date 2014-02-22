From: dashie@sigpipe.me (Dashie)
Date: Sat, 22 Feb 2014 20:00:04 +0100
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <20140221200855.GM7862@titan.lakedaemon.net>
References: <5306721B.7020403@sigpipe.me>
 <20140221013407.GX7862@titan.lakedaemon.net> <5307029C.20006@sigpipe.me>
 <20140221151530.GZ7862@titan.lakedaemon.net> <5307A727.9080508@sigpipe.me>
 <20140221200855.GM7862@titan.lakedaemon.net>
Message-ID: <5308F3B4.6010409@sigpipe.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/21/2014 09:08 PM, Jason Cooper wrote:
>> Well, with kirkwood_defconfig it doesn't find the SATA PHY and panic.
>> So i've used my debian config, make oldconfig, built and ... the toy is
>> booting.
> Yes, this is a known issue.  You worked around it by enabling generic
> phy support (it's most likely in the other configs).
Well, i've done some more tests and found that i've commented the
sata at 80000 {} part of the DTS, but does not remember if that was after
trying "debian config".

If i uncomment it, i got the kernel panic with "sata_mv f1080000.sata:
unable to find phy".

About generic phy, is it CONFIG_GENERIC_PHY ? I't already to =y in my
.config actually.
I have CONFIG_PHY_MVEBU_SATA=y and CONFIG_SATA_MV=y too.

Dashie.
