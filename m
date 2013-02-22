From: lethal@linux-sh.org (Paul Mundt)
Date: Sat, 23 Feb 2013 01:25:00 +0900
Subject: [PATCH 8/8] ARM: smp: Remove local timer API
In-Reply-To: <20130222111545.GA15020@e106331-lin.cambridge.arm.com>
References: <1361518039-16663-1-git-send-email-sboyd@codeaurora.org>
 <1361518039-16663-9-git-send-email-sboyd@codeaurora.org>
 <20130222111545.GA15020@e106331-lin.cambridge.arm.com>
Message-ID: <20130222162458.GA19670@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 11:15:45AM +0000, Mark Rutland wrote:
> One thing that struck me when I was fiddling with the broadcast mechanism was
> that it should be possible to have a generic dummy timer implementation. As
> long as the architecture calls notifiers at the appropriate times, it should
> look like any other timer driver (apart from not touching any hardware). It just
> needs to depend on ARCH_HAS_TICK_BROADCAST.
> 
> I believe it shouldn't be too difficult to implement, though I may be blind to
> some problems.
> 
It would be nice to have a generic dummy timer driver, quite a few
architectures could use it directly already. If no one beats me to it,
I'll give it a go as I convert the SH stuff over to using
ARCH_HAS_TICK_BROADCAST and killing off the local timer API there.
