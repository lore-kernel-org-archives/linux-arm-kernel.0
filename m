From: joe@perches.com (Joe Perches)
Date: Wed, 21 Jan 2015 08:05:21 -0800
Subject: unclear ipv6 redirect message (was Re: [PATCH v3 2/3] mfd:
 lubbock_io: add lubbock_io board)
In-Reply-To: <20150121094453.GO26493@n2100.arm.linux.org.uk>
References: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
 <1421406010-14851-2-git-send-email-robert.jarzmik@free.fr>
 <20150119091705.GG21886@x1> <87ppaah9k5.fsf@free.fr>
 <20150120102919.GP5767@x1> <20150120115658.GJ26493@n2100.arm.linux.org.uk>
 <873874fuei.fsf@free.fr> <20150121094453.GO26493@n2100.arm.linux.org.uk>
Message-ID: <1421856321.10574.13.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding netdev)

On Wed, 2015-01-21 at 09:44 +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 21, 2015 at 08:46:29AM +0100, Robert Jarzmik wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > 
> > > What I'd suggest (and always have done) is:
> > >
> > > 	dev_err(&pdev->dev, "couldn't request main irq%d: %d\n",
> > > 		irq, ret);
> > I like it, it's even more compact, I'll use it for next patch version.
> 
> BTW, this is an example why I have the policy of always ensuring that
> the kernel messages print sufficient diagnostics.  Right now, I have
> a problem - since I rebooted my firewall a few nights ago, I now get
> on one of my machines:
> 
>   rt6_redirect: source isn't a valid nexthop for redirect target
> 
> and it spews that for a few minutes every 26 hours or so.  No further
> information, and it leaves you wondering "well, what was the invalid
> next hop?  What was the source?"
> 
> Pretty much the only way to try and find out is to leave a tcpdump or
> wireshark running for 24 hours to try and get a dump - which is not
> that easy if you don't have lots of disk space.  So, right now, I have
> no way to diagnose the above.
> 
> If it printed that information, then I'd be able to see what the
> addresses were, and I'd probably be able to come up with a tcpdump
> filter which didn't involve logging all IPv6 traffic.
> 
> Kernel messages need to be smart.  If not, they might as well just be
> "The kernel encountered a problem. Abort, Retry or Fail?"
> 
