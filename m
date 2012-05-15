From: stigge@antcom.de (Roland Stigge)
Date: Tue, 15 May 2012 15:48:28 +0200
Subject: [PATCH] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1337088703.2528.208.camel@sauron.fi.intel.com>
References: <1336829386-23301-1-git-send-email-stigge@antcom.de>
 <1337068543.2528.143.camel@sauron.fi.intel.com>
 <4FB2109A.2080505@freescale.com> <4FB25837.2050603@antcom.de>
 <1337088703.2528.208.camel@sauron.fi.intel.com>
Message-ID: <4FB25EAC.10205@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2012 03:31 PM, Artem Bityutskiy wrote:
>> As I understand loops_per_jiffy, this loop will take much longer
>> than the 100 ms you defined above?
> 
> Not sure about much, but longer. The idea is that this is about
> the error path so if we report -EIO with a slight delay - no
> problem.

Turned out that the condition (FIFO empty) is always true for me.
Keeping the check for safety reasons for now, doing the timeout with
msleep()s which should be (cpu-wise) "social" enough and are
unexpected anyway but do approximate the ms timeout more precisely.

Roland
