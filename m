From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 16 Apr 2013 18:21:08 +0200
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <516D74E9.9030404@wwwdotorg.org>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
 <516C544A.4090107@wwwdotorg.org>
 <20130416104545.GA19837@e102568-lin.cambridge.arm.com>
 <516D74E9.9030404@wwwdotorg.org>
Message-ID: <1366129268.24994.60.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-04-16 at 09:57 -0600, Stephen Warren wrote:
> > Mmm, I need to read more on dtc+cpp, I do not think that leaving it
> > as a string would hurt though, am I wrong ? Can we assume that all
> dts
> > are preprocessed before being compiled and passed to the kernel ?
> 
> It wouldn't hurt too much, but representing enums as strings when
> there's a capability to simply represent it as a integer just feels
> pretty gross to me.

It's the other way around...

Unless there's a direct semantic meaning of the numbers, things like
that (ie. "methods") should be represented as strings.

Else we fall back to the realm of "magic numbers" which sucks and causes
all sort of pains when several new methods get added by different
people, etc...

The tree is meant to be generally human readable and we should stick to
that. The tiny memory usage is irrelevant on any modern setup.

Cheers,
Ben.
