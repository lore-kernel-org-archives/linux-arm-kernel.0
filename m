From: josh.coombs@gmail.com (Josh Coombs)
Date: Thu, 21 Jun 2012 10:32:18 -0400
Subject: [RFC PATCH] ARM: Initial DTS support for Kirkwood GoFlex
In-Reply-To: <20120621141156.GA12038@lunn.ch>
References: <20120621141156.GA12038@lunn.ch>
Message-ID: <CAMW5UfbhxbsY0GsB7TQ_b7hjnSRga27-7Xbop8h2Xn7wjJtgUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 10:11 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> Without the clock patch:
>> - No NAND definitions anywhere - doesn't complete a boot
>> - NAND defined and initialized in board-goflexnet.c - complete boot
>> with NAND accessible
>> - NAND defined via DT - doesn't complete a boot, stops at same point
>> as with no NAND definitions
>
> I'm surprised about the last. Is MTD finding the NAND device and
> creating the partitions and devices?

According to the kernel dmesg output during init it sees it and lists
the partitions and their associated devices correctly.

>> To move forward, do I assume the clock patch is going to be pulled
>> into mainline and submit my patch as depending on it, with NAND
>> defined in the DT, or for now submit with it defined and initialized
>> via the board file until the DT issue can be resolved?
>
> The patch has been accepted and should appear in the next -rc.
>
> ? ?Andrew

I'll make sure my patch is clean then and submit with NAND defined via DT.

Josh C
