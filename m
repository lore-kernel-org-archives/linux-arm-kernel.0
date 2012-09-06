From: imp@bsdimp.com (Warner Losh)
Date: Wed, 5 Sep 2012 22:54:07 -0600
Subject: [PATCH 3/8] i2c: at91: use an id table for SoC dependent
 parameters
In-Reply-To: <504395B1.2040203@gmail.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346404884-18451-4-git-send-email-ludovic.desroches@atmel.com>
 <20120831142944.GA23867@game.jcrosoft.org> <5040CF80.8060201@atmel.com>
 <504122D3.70507@gmail.com> <20120901091054.GA17540@game.jcrosoft.org>
 <504395B1.2040203@gmail.com>
Message-ID: <FAD1B09E-FB34-490F-A712-0EA73E50FD63@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 2, 2012, at 11:21 AM, Sylwester Nawrocki wrote:

> On 09/01/2012 11:10 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 22:47 Fri 31 Aug     , Sylwester Nawrocki wrote:
>>> On 08/31/2012 04:51 PM, Nicolas Ferre wrote:
>>>> No, it does not have to be exposed to the user: these data are highly
>>>> dependent on the actual hardware (IP revision in fact). So, no need to
>>>> mess with platform data.
>> no I really see no point on these list of platform_id it's does not look more
>> nice just more huggly to have x names. This is at the end the same as passing
>> platform data via soc info (add_xx or dtsi)
>> 
>> And here you just do the same as cpu_is via names.
>> 
>> The driver need to read IP revision instead
> 
> OK, but wouldn't it be needed to resolve an IP revision at run time, e.g.
> with soc_is_*() anyway ? Having it set at each board doesn't look like an 
> optimal method either.

I'd much rather have a DT setting that gives the IP version in some manner, so I can key work arounds off of that.  Not so important for legacy devices where the Errata are well known (since you could do the same thing with some kind of property that's a boolean like for the AT91RM9200's mci controller that needs to swap bytes).  However, given my experience of bringing the FreeBSD at91rm9200 port to life and taking a product to market with it, I'd anticipate that the Errata will evolve over time, as will the need for workarounds.  Having an IP version helps deploy new drivers to the field without needing new DT files.

As you can tell, I'm not a big soc_is_* fan...

Warner
