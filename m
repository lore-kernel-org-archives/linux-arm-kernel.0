From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Feb 2016 14:10:31 +0100
Subject: [PATCH RFC] Add cpufreq support
In-Reply-To: <20160208124127.GF8294@vireshk>
References: <56B4D4BE.2040008@free.fr> <45004963.Im3DmqJ5ez@wuerfel>
 <20160208124127.GF8294@vireshk>
Message-ID: <22002072.L04zy0K2AP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 18:11:27 Viresh Kumar wrote:
> On 08-02-16, 13:34, Arnd Bergmann wrote:
> > Maybe add a opp-v3 compatible string?
> 
> How will that help?
> 
> The problem was that the compatibility string of "opp-v2" specifies
> the way we need to parse the bindings and shouldn't be (ab)used to
> probe a driver like cpufreq-dt. And so we got stuck.

I don't remember the exact discussion, but the compatible string is
exactly meant to do one thing: it tells you what you can or cannot do
with one device.

I had not realized that we don't even have a compatible string
for opp-v2, so if we are missing that, we obviously can't compare
against that string.

> > I really don't care what you
> > match on, as long we don't need any code in arch/arm/ to create a
> > device we don't need.
> 
> Sure.
> 
> > Don't add the device to DT, we really don't want that.
> 
> I agree.
> 
> > If there
> > is too much opposition to looking at the cpus nodes in the initcall,
> 
> I didn't get this one, what can we do by looking at CPUs nodes ?

I thought there was a compatible property in there that told us
whether the operating-points-v2/cooling-min-level/#cooling-cells/...
properties were considered valid.

> > start with a whitelist for known machines, that at least keeps the
> > existing behavior.
> 
> That can be a valid solution I would say, but that separate driver
> (cpufreq-dt-device.c) needs to be changed for every new platform.

Until we can agree on a way to describe in the DT whether the opp
properties are reliable or not.

	Arnd
