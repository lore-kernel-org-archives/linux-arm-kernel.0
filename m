From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Apr 2013 18:24:09 +0200
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <516EBC66.20508@wwwdotorg.org>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
 <516C544A.4090107@wwwdotorg.org>
 <20130417091457.GB5012@e106331-lin.cambridge.arm.com>
 <516EBC66.20508@wwwdotorg.org>
Message-ID: <1366215849.24994.70.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-17 at 09:14 -0600, Stephen Warren wrote:
> On 04/17/2013 03:14 AM, Mark Rutland wrote:
> > Hi Stephen,
> > 
> >>> +	- enable-method
> >>> +		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
> >>> +		       systems
> >>> +		Value type: <string>
> >>> +		Definition: On ARM 64-bit systems must be "spin-table" [1].
> >>
> >> Can that be an integer instead? with dtc+cpp support, that shouldn't
> >> hurt the eyes too much any more.
> > 
> > The "enable-method" property is described as a stringlist by ePAPR, and is
> > currently in use on arm64 as such. It *must* remain a string(list) for arm64.
> > 
> > Having it as an integer for arm is only going to cause us additional work,
> > makes it impossible to share a common dt between 64bit and 32bit, and goes
> > against the standard. I think it should be a stringlist for arm.
> 
> OK, that's a great reason for this case.
> 
> I hope we don't introduce any more standards that use strings, but that
> may just be my personal preference...

I happen to have the exact opposite opinion :-)

Cheers,
Ben.
