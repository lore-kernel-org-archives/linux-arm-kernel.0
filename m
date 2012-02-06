From: hs@denx.de (Heiko Schocher)
Date: Mon, 06 Feb 2012 07:36:11 +0100
Subject: [RFC PATCH 1/7] ARM: davinci,
 intc: Add OF support for TI interrupt controller
In-Reply-To: <20120202045459.GI15343@ponder.secretlab.ca>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-2-git-send-email-hs@denx.de>
 <20120202045459.GI15343@ponder.secretlab.ca>
Message-ID: <4F2F74DB.7010604@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grant,

Grant Likely wrote:
> On Mon, Jan 23, 2012 at 09:56:01AM +0100, Heiko Schocher wrote:
>> Add a function to initialize the davinci interrupt controller (INTC)
>> using a device tree node.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Wolfgang Denk <wd@denx.de>
>> ---
>>  .../devicetree/bindings/arm/davinci/intc.txt       |   26 ++++++++++
>>  arch/arm/mach-davinci/cp_intc.c                    |   51 ++++++++++++++++++++
>>  arch/arm/mach-davinci/include/mach/cp_intc.h       |    1 +
>>  3 files changed, 78 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/davinci/intc.txt
[...]
>> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
>> index f83152d..2c6e2e4 100644
>> --- a/arch/arm/mach-davinci/cp_intc.c
>> +++ b/arch/arm/mach-davinci/cp_intc.c
[...]
>> +	cp_intc_init();
>> +	irq_domain_add_simple(node, 0);
> 
> Take a look at the irq_domain patches that will be (probably) merged
> in v3.4.  Instead of calling irq_domain_add_simple(), you should
> migrate the whole interrupt controller to natively use an irq_domain
> for hwirq <--> irq mapping.

I rebased my hole patchset to:

git://git.secretlab.ca/git/linux-2.6.git irqdomain/next
and reworked the arch/arm/mach-davinci/cp_intc.c irq driver to use
irq_domain, works good on the enbw_cmc board :-)

Waiting for your comment to my question to the
[RFC PATCH 7/7] ARM: davinci: add support for the am1808 based enbw_cmc board
patch, see:
http://www.mail-archive.com/linux-i2c at vger.kernel.org/msg07132.html

and resend the hole reworked patchserie. Is it OK, if I use the above
branch as base for sending this patchserie, or should I use another
tree/branch for it?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
