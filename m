From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Apr 2013 12:36:08 -0400 (EDT)
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <516ECC8A.2070508@wwwdotorg.org>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
 <516C544A.4090107@wwwdotorg.org>
 <20130417091457.GB5012@e106331-lin.cambridge.arm.com>
 <516EBC66.20508@wwwdotorg.org>
 <alpine.LFD.2.03.1304171146530.17375@syhkavp.arg>
 <516ECC8A.2070508@wwwdotorg.org>
Message-ID: <alpine.LFD.2.03.1304171231130.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Apr 2013, Stephen Warren wrote:

> On 04/17/2013 10:02 AM, Nicolas Pitre wrote:
> > On Wed, 17 Apr 2013, Stephen Warren wrote:
> > 
> >> On 04/17/2013 03:14 AM, Mark Rutland wrote:
> >>> Hi Stephen,
> >>>
> >>>>> +	- enable-method
> >>>>> +		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
> >>>>> +		       systems
> >>>>> +		Value type: <string>
> >>>>> +		Definition: On ARM 64-bit systems must be "spin-table" [1].
> >>>>
> >>>> Can that be an integer instead? with dtc+cpp support, that shouldn't
> >>>> hurt the eyes too much any more.
> >>>
> >>> The "enable-method" property is described as a stringlist by ePAPR, and is
> >>> currently in use on arm64 as such. It *must* remain a string(list) for arm64.
> >>>
> >>> Having it as an integer for arm is only going to cause us additional work,
> >>> makes it impossible to share a common dt between 64bit and 32bit, and goes
> >>> against the standard. I think it should be a stringlist for arm.
> >>
> >> OK, that's a great reason for this case.
> >>
> >> I hope we don't introduce any more standards that use strings, but that
> >> may just be my personal preference...
> > 
> > I think in any standard, strings are far easier to deal with.  
> > Especially with config stuff which is far from being performance 
> > critical. Strings are much less prone to conflicts.  It is too easy to 
> > "extend" a standard by assigning meanings to free numerical values just 
> > to discover that someone else did use the same numbers for other 
> > meanings.
> > 
> > In order to avoid this issue, a central authority has to be established 
> > to assign numbers out while strings are fine without that most of the 
> > time.
> 
> For DT, all strings or numbers must always be documented in the DT
> binding, so there's no risk of conflict there.

No, that's not good enough.  Most of the time, DT properties are created 
during development way earlier than any publication of them.  Picking a 
random number is just creating trouble whereas a string might just be 
right from the start.

Furthermore, what's the point to obfuscate a property name behind a 
numerical indirection?  If what you want to describe is a number then 
just use a number.  But if you want to describe a property, a method, or 
any other attribute with no direct relation to a number except for the 
only purpose of enumeration then there is just no point not to use a 
string up front.


Nicolas
