From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Jun 2015 14:40:48 +0200
Subject: [PATCH] clk: at91: add generated clock driver
In-Reply-To: <1434614090.2385.19.camel@x220>
References: <1434547409-12232-1-git-send-email-nicolas.ferre@atmel.com>		<1434611556.2385.8.camel@x220>
 <20150618093344.7d486e97@bbrezillon>	 <55827606.7020908@atmel.com>
 <1434614090.2385.19.camel@x220>
Message-ID: <5582BC50.1050801@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/06/2015 09:54, Paul Bolle a ?crit :
> Hi Nicolas,
> 
> On Thu, 2015-06-18 at 09:40 +0200, Nicolas Ferre wrote:
>> I am in the process, with my colleagues, of building bricks for our
>> upcoming SoC the sama5d2. So, the basic support for this chip will come
>> in the next weeks and will select this Kconfig option.
> 
> Perhaps that could be added, say below the --- marker in the patch.

Yep, I should have added that, for sure!

> Maybe I missed something to that effect. Anyhow, I didn't spot in the
> patch that this was done deliberately. It had all the looks of a silly
> mistake.
> 
>> I'd like though that this matter of fact doesn't block this piece of
>> code from being reviewed or even better merged in order to ease this new
>> SoC landing...
> 
> The other side of that is that the sama5d2 might never make it, or take
> very long to make it, into mainline. And this would then end up being
> yet another chunk of code adding no value to mainline.

C'mon Paul, it's a simple chicken and egg problem... I have several
options here:

1/ I send the clock patch early and benefit from early review and a
comfortable landing strip

2/ I send the SoC early and have the very same remark concerning the
"+       select HAVE_AT91_GENERATED" line in my patch

3/ I do it in several separated series... but at the price of additional
synchronization between subsystems, additional dumb patches with so
little benefit in my opinion.

Ok, so I post sama5d2 early support today so that we can agree it's not
necessary to add superfluous steps.

Bye,
-- 
Nicolas Ferre
