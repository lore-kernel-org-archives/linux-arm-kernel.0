From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Aug 2013 18:46:13 +0200
Subject: [PATCH 1/8] ARM: at91: move peripheral id definitions to
 dt-bindings include dir
In-Reply-To: <520319DE.5090100@overkiz.com>
References: <1375339733-3488-1-git-send-email-b.brezillon@overkiz.com>
 <1375339933-3643-1-git-send-email-b.brezillon@overkiz.com>
 <201308072224.30614.arnd@arndb.de> <520319DE.5090100@overkiz.com>
Message-ID: <52124BD5.5060801@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 06:09, boris brezillon :
> Hello Arnd,
>
> On 07/08/2013 22:24, Arnd Bergmann wrote:
>> On Thursday 01 August 2013, Boris BREZILLON wrote:
>>> This patch moves peripheral id definitions from machine specific include
>>> dir (arch/arm/mach-at91/include/mach/'soc-name'.h) to dt-bindinds include
>>> dir (include/dt-bindings/at91/'soc-name'/peripherals.h).
>>>
>>> These definitions will be used inside dt to define interrupt ids and
>>> peripheral clk ids.
>>>
>>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> This seems counterproductive, why would you do that?
>
> This was requested by Jean-Christophe Plagniol-Villard (and proposed by
> Richard Genoud)
> for the 3rd version of the "ARM: at91: move to common clk framework"
> patch series (see
> https://lkml.org/lkml/2013/7/29/361) and thought it was a good idea too
> (even if I didn't know
> where to put the macro files as there are no soc specific macro files in
> dt-bindings include
> dir).
>
> Indeed I found it much easier to detect bugs in dt definition using
> macros because
> the macro names and dt node names are the same (it does not protect
> against errors
> in the macro definitions).
>
> If you think these macro definitions should be dropped, I won't argue
> against this.
> But please, have a talk with Jean-Christophe first.

[..]

>> There is no sharing of identifiers across SoCs here, you just move the
>> data around, and changing the .dts files to use the abstract macros would
>> just end up making them harder to understand, not easier, since you then
>> have to look up the numbers in another file.

Boris, Jean-Christophe and Richard,

Well, I must say that I do agree with Arnd on this point.

I think that a simple numeric field in a cell has to be represented as a 
number and even if this simple information is used twice (interrupt 
number and clock bit position in PMC). The possibility of error is very 
low compared to the big amount of unneeded definitions added by this 
solution.

Moreover, I had the hope to completely remove this long list of 
peripheral definitions for all SoC when we have a full DT kernel (with 
your patches about common clock framework). So I think it is not 
interesting to move in this direction and continue to build such a list 
for future full DT products...

Believe me, I am sorry that I didn't entered the discussion earlier and 
avoid unnecessary work... Anyway, give me your opinion, but I do think 
that the simpler is the best.

Bye,
-- 
Nicolas Ferre
