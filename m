From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 Oct 2013 11:55:01 +0200
Subject: [PATCH v2] clk: armada-370: fix tclk frequencies
In-Reply-To: <20131014085323.GL1356@kw.sim.vm.gnt>
References: <1380794702-6191-1-git-send-email-simon.guinot@sequanux.org>
 <20131003122307.GV31178@titan.lakedaemon.net>
 <20131009073633.GH1356@kw.sim.vm.gnt> <20131014085323.GL1356@kw.sim.vm.gnt>
Message-ID: <525BBF75.5010305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2013 10:53, Simon Guinot wrote:
> On Wed, Oct 09, 2013 at 09:36:33AM +0200, Simon Guinot wrote:
>> On Thu, Oct 03, 2013 at 08:23:07AM -0400, Jason Cooper wrote:
>>> Simon,
>>>
>>> On Thu, Oct 03, 2013 at 12:05:02PM +0200, Simon Guinot wrote:
>>>> This patch fixes the tclk frequency array for the Armada-370 SoC.
>>>> This bug has been introduced by commit 6b72333d
>>>> ("clk: mvebu: add Armada 370 SoC-centric clock init").
>>>>
>>>> A wrong tclk frequency affects the following drivers: mvsdio, mvneta,
>>>> i2c-mv64xxx and mvebu-devbus. This list may be incomplete.
>>>>
>>>> About the mvneta Ethernet driver, note that the tclk frequency is used
>>>> to compute the Rx time coalescence. Then, this bug harms the coalescence
>>>> configuration and also degrades the networking performances with the
>>>> default values.
>>>>
>>>> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
>>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>>> Cc: stable at vger.kernel.org
>>>> ---
>>>>  drivers/clk/mvebu/armada-370.c |    4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> Much better, thanks!
>>>
>>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>>
>>> This can be applied to v3.11 onwards.
>>
>> Hi Mike,
>>
>> Please consider applying this patch.
> 
> Ping ?

Mike,

this bug could be very annoying. We had some issue recently with i2c,
and I am pretty sure it was caused by this wrong rate.
So it would be nice to have this fix in 3.12, and then on the stable
branches.

Of course you can also add my:
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,


> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
