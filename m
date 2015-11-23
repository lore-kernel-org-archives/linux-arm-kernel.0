From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 23 Nov 2015 19:17:44 +0100
Subject: [PATCH] ARM: mvebu: add reference to ETH connectors for A385-AP
In-Reply-To: <CAPv3WKduZLK1_cgnWYUnBYw19YFxik9B8o-MPiZO6OvfvhhEWQ@mail.gmail.com>
 (Marcin Wojtas's message of "Tue, 17 Nov 2015 17:37:27 +0100")
References: <1447775620-25919-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <7560280.yqEeu9J2fA@wuerfel>
 <20151117162118.GQ8644@n2100.arm.linux.org.uk>
 <CAPv3WKduZLK1_cgnWYUnBYw19YFxik9B8o-MPiZO6OvfvhhEWQ@mail.gmail.com>
Message-ID: <8737vwfulz.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,
 
 On mar., nov. 17 2015, Marcin Wojtas <mw@semihalf.com> wrote:

> Hi,
>
> How about swapping the ethernet@ entries in the board DT files to gain
> following order:
> ethernet at 70000
> ...
> ethernet at 30000
> ...
> ethernet at 34000
>
> I know this would introduce deviation from epapr rules, but it always
> worked for me.

Given there is no other solution, for my side I would agree on such
change with the accurate comments inside the dts at the place we should
fine the node.

Gregory

>
> Best regards,
> Marcin
>
> 2015-11-17 17:21 GMT+01:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> On Tue, Nov 17, 2015 at 04:57:20PM +0100, Arnd Bergmann wrote:
>>> On Tuesday 17 November 2015 16:53:40 Thomas Petazzoni wrote:
>>> > This commit adds some comments to the Armada 385 AP Device Tree
>>> > description to indicate which Ethernet interface matches which
>>> > physical connector on the board.
>>> >
>>> > This is especially useful on this board, since the mapping between the
>>> > logical interface names and the physical ports is not very
>>> > straightforward. It also doesn't match the numbering of the interfaces
>>> > done by U-Boot:
>>> >
>>> >  U-Boot interface | Linux interface | Physical port
>>> >  -----------------+-----------------+--------------
>>> >    egiga0         |     eth2        |   CON4
>>> >    egiga1         |     eth0        |   CON2
>>> >    egiga2         |     eth1        |   CON3
>>> >  -----------------+-----------------+--------------
>>> >
>>> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> >
>>>
>>> Would it be possible to use entries in /aliases to fix the order of the
>>> interfaces and make them match the physical ports?
>>
>> Unfortunately not, and I believe davem is averse to "fixing" this problem
>> in the kernel.  It's really problematical, especially if you are running
>> a debian based distro and want to be able to say "I want egiga0 configured
>> like _this_".  You're entirely at the mercy of the ordering that the DT
>> compiler decides to place the nodes, and the ordering which the kernel
>> decides to probe the interfaces, etc.
>>
>> Yes, there's always the ethernet MAC which can be used to identify them,
>> but debian at least doesn't have a way to identify interfaces in its
>> /etc/network/interfaces file by ethernet MAC.
>>
>> So, use the modern network-manager daemon... umm no, not if you want to
>> use bridging or any of the other such facilities.
>>
>> This whole area is really very annoying.
>>
>> --
>> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
>> according to speedtest.net.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
