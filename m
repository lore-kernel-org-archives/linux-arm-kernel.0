From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Fri, 07 Feb 2014 12:00:18 -0300
Subject: [PATCH] clk: respect the clock dependencies in of_clk_init
In-Reply-To: <52F4F279.6010006@free-electrons.com>
References: <1391554766-11285-1-git-send-email-gregory.clement@free-electrons.com>
 <52F4DA40.4090804@elopez.com.ar> <20140207142430.GU8533@titan.lakedaemon.net>
 <20140207144325.GA8218@localhost> <52F4F279.6010006@free-electrons.com>
Message-ID: <52F4F502.2010703@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 07/02/14 11:49, Gregory CLEMENT escribi?:
> On 07/02/2014 15:43, Ezequiel Garcia wrote:
>> On Fri, Feb 07, 2014 at 09:24:30AM -0500, Jason Cooper wrote:
>>> On Fri, Feb 07, 2014 at 10:06:08AM -0300, Emilio L?pez wrote:
>>>
>>> [snip a great explanation]
>>>
>>> Guys, can I get some Tested-by's on this?
>>>
>>
>> In case someone missed Emilio's comment about it, I gave his oneliner
>> a test on A370 Reference Design. It worked just as well as Sebastian's.
>
> Well ok it's working but this patch is not better than Sebastian, it is
> even worth. I don't think it is a good idea at all to totally ignore the
> information given by the device tree.

With a bit more work, you can replace the clk_get magic with a call to 
of_clk_get_parent_name() or similar to be able to keep overriding stuff 
from DT. This way it would completely match the behaviour on 
mvebu_coreclk_setup (default to "tclk", allow overriding with DT).

Emilio
