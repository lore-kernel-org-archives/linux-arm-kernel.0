From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 13 Aug 2012 10:42:58 -0500
Subject: [PATCH] efikamx: reintroduce Genesi Efika MX Smarttop via device
 tree
In-Reply-To: <20120809101947.GA8474@sirena.org.uk>
References: <1344375978-29981-1-git-send-email-matt@genesi-usa.com>
 <20120809101947.GA8474@sirena.org.uk>
Message-ID: <CAKGA1bkwMvDW7nMWxUbNm3_0ZTR2+uKs8UL_HuisJe7cd8POBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:19 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Aug 07, 2012 at 04:46:18PM -0500, Matt Sealey wrote:
>
> Yay for indentation!  It'd be good to rewrite your DT so you could cut
> down on that, at the minute it's not good for legibility.
>
>> +                                                     sw1_reg: sw1 {
>> +                                                             regulator-min-microvolt = <600000>;
>> +                                                             regulator-max-microvolt = <1375000>;
>> +                                                             regulator-boot-on;
>> +                                                             regulator-always-on;
>> +                                                     };
>
> This and many of your other regulators have voltage ranges specified but
> no consumers which doesn't make sense.  It looks awfully like you've
> just typed in the maximum range supported by the regulator which is most
> likely broken.

Okay I have a question about this; some of the regulators (SW1
especially) are obviously consumed by the CPU core complex so that
when DVFS gives us a hint we can clock down and reduce voltage. How on
earth do we implement that?

We can drop the maximum range to be better for the CPU (1.3V is too
high, I think this is legacy from when we may have had a sorted 1GHz
MX51 coming out) but I can't find any source for where this is hooked
in.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
