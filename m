From: dt.tangr@gmail.com (Daniel Tang)
Date: Sun, 19 May 2013 21:09:17 +1000
Subject: [RFC PATCHv3 3/6] clk: Add TI-Nspire clock drivers
In-Reply-To: <201305161417.28133.arnd@arndb.de>
References: <1368332581-94691-1-git-send-email-dt.tangr@gmail.com>
 <201305151607.54442.arnd@arndb.de>
 <15FD6543-D04A-4953-A56A-40B27F0026E4@gmail.com>
 <201305161417.28133.arnd@arndb.de>
Message-ID: <F8915E01-0FCA-4C9F-8440-63B5A73B349B@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 16/05/2013, at 10:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 16 May 2013, Daniel Tang wrote:
>> 
>> On 16/05/2013, at 12:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> 
>>> You are missing a binding in Documentation/devicetree, same as for some of
>>> the other drivers in this series.
>> 
>> Should we be adding a vendor prefix to it too? If so, we're not sure whether
>> to use "ti," or not since this isn't an official port by TI.
> 
> The binding describes the hardware, it should not matter who does the port.
> However, any part of the tree that is not actually from TI should have a
> vendor prefix indicating who made that part. IIRC, the SoC used in there
> is from TI, so you should use something else for the on-soc components.
> 

If the vendors for the on-SOC components are unknown, should we just leave the compatible strings as is (i.e. "nspire-XXX")?

>>> It seems strange to assign the clk_name variable to node->name
>>> first and then overriding it with the clock-output-names property.
>>> Is that intentional? If so, please explain it in a comment.
>>> 
>> 
>> I copied that bit of boilerplate from drivers/clk/clk-fixed-rate.c but
>> I'm guessing it's to use the node name as the clock name unless there
>> is a property called "clock-output-names"
> 
> Ah, I see. It seems you forgot to add the clock maintainer to Cc in the
> mail. Mike is the one who will have to take you patch anyway, so I assume
> he will comment on this if you did it wrong.
> 
> 	Arnd
