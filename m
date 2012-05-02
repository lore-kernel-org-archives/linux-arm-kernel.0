From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 02 May 2012 23:31:31 +0200
Subject: [PATCH 1/1] ARM: kirkwood: Add support for RaidSonic
In-Reply-To: <op.wdonrhzb4cuzmg@gonzo.lentin.co.uk>
References: <20120501172042.GA13233@lunn.ch>
 <alpine.DEB.2.00.1205011902150.23719@marmot.wormnet.eu>
 <20120501195603.GW25584@lunn.ch> <op.wdonrhzb4cuzmg@gonzo.lentin.co.uk>
Message-ID: <4FA1A7B3.8070106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie, Andrew,

Am 02.05.2012 15:29, schrieb Jamie Lentin:
>>> >How about writing a gpio-poweroff platform driver? It would take a
>>> >platform_data structure which lists which GPIO line to use, and if it
>>> >should be active high/low. The probe function would take control of
>>> >the GPIO line, set it to inactive state, and output. It would also
>>> >register a function for pm_power_off(). When that function is called,
>>> >it toggles the GPIO to turn the power off.
>>> >
>>> >Then wrap all this up in a DT binding.
>>>
>>> I've been thinking about this too, would make a lot of sense. Most
>>> of the gpio-poweroff driver would be easy, although registering the
>>> power_off function wasn't immediately obvious.
>>
>> pm_power_off is a global variable. You should be able to assign it
>> from anywhere.
> >
>
> It seemed a bit worrying setting the global within a driver when it
> might be overridden elsewhere, but I guess it's fairly unlikely a
> board would invoke several means of turning off. A grep shows several
> drivers that already do this (setting pm_power_off) anyway. I'll have
> a go at writing one later.

This saves me a long-winded explanation why I would prefer someone more
experienced to do this before I give it a try...
Of course I am happy to support e.g. by testing. Just let me know.

Andrew, thanks for the review of the ib62x0 patch. Once there is a
gpio-poweroff driver, should I integrate the adaptations to use it into
the existing patch or would you like to have a dedicated patch for that?
(I prefer the latter.)

- Simon
