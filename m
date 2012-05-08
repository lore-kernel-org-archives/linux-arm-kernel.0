From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 08 May 2012 13:38:18 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <20120508121940.GL15893@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FA90BE1.3050304@linaro.org>
 <20120508121940.GL15893@opensource.wolfsonmicro.com>
Message-ID: <4FA913BA.30908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/12 13:19, Mark Brown wrote:
> On Tue, May 08, 2012 at 01:04:49PM +0100, Lee Jones wrote:
>> On 07/05/12 18:08, Mark Brown wrote:
>
>>> You should be using of_regulator_match() for this (I think it's supposed
>>> to do an equivalent job...) rather than open coding.
>
>> of_regulator_match() didn't exist when I wrote this. In fact, it
>> only made it into -next a couple of days ago. Besides, it doesn't
>
> It's been kicking around for review for a little while longer than that
> (it was waiting for review while Rhyland was on holiday), and in any
> case half the reason for adding infrastructure is to avoid adding
> repeated code.

I'm sorry Mark, but I just don't have the time to read all of the 
mailing lists in order to keep up with, and in-turn use all of the new 
features which might make it upstream. I only use what I see in the 
kernel at time of writing, as I have an entire platform to enable and 
very little time in which to do it.

>> satisfy the needs of this code segment. of_regulator_match() is
>> a(nother) wrapper around of_get_regulation_constraints(), which is
>> only used to populate 'struct regulation_constraints constraints'
>> after being provided with a selection of .compatible strings.
>
> I suspect that what you're trying to achieve isn't a good regulator
> binding but I'm not entirely sure what you're trying to do so perhaps
> not.  You haven't documented the binding at all which might make things
> clearer...

Right, I agree with you. I certainly will knock up some documentation 
for them.

This piece of code plucks pre-defined initialisation values and from the 
Device Tree and uses them to set-up regulator related registers on the 
u8500. See 'struct ab8500_regulator_reg_init ab8500_regulator_reg_init' 
in arch/arm/mach-ux500/board-mop500-regulators.c for reference.

I did run this past Arnd before writing the code and he agreed that this 
would be suitable; however, if you know of a better way in which I can 
do this, I'd be pleased to hear of it.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
