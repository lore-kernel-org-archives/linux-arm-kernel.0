From: george.dunlap@eu.citrix.com (George Dunlap)
Date: Thu, 16 Apr 2015 09:56:22 +0100
Subject: [Xen-devel] "tcp: refine TSO autosizing" causes performance
 regression on Xen
In-Reply-To: <1429121979.7346.138.camel@edumazet-glaptop2.roam.corp.google.com>
References: <alpine.DEB.2.02.1504091344260.7690@kaball.uk.xensource.com>
 <1428596218.25985.263.camel@edumazet-glaptop2.roam.corp.google.com>
 <alpine.DEB.2.02.1504091729160.7690@kaball.uk.xensource.com>
 <CAFLBxZaVjFHh4UBnksGZS4waBr4jLdO8aJegyKvsU1-TvVt2Dg@mail.gmail.com>
 <1428932970.3834.4.camel@edumazet-glaptop2.roam.corp.google.com>
 <CAFLBxZYt7-v29ysm=f+5QMOw64_QhESjzj98udba+1cS-PfObA@mail.gmail.com>
 <1429115934.7346.107.camel@edumazet-glaptop2.roam.corp.google.com>
 <552E9E8D.1080000@eu.citrix.com>
 <1429118948.7346.114.camel@edumazet-glaptop2.roam.corp.google.com>
 <552EA2BC.5000707@eu.citrix.com>
 <1429120373.7346.125.camel@edumazet-glaptop2.roam.corp.google.com>
 <552EA844.5010308@eu.citrix.com>
 <1429121979.7346.138.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <552F7936.9070205@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2015 07:19 PM, Eric Dumazet wrote:
> On Wed, 2015-04-15 at 19:04 +0100, George Dunlap wrote:
> 
>> Maybe you should stop wasting all of our time and just tell us what
>> you're thinking.
> 
> I think you make me wasting my time.
> 
> I already gave all the hints in prior discussions.

Right, and I suggested these two options:

"Obviously one solution would be to allow the drivers themselves to set
the tcp_limit_output_bytes, but that seems like a maintenance
nightmare.

"Another simple solution would be to allow drivers to indicate whether
they have a high transmit latency, and have the kernel use a higher
value by default when that's the case." [1]

Neither of which you commented on.  Instead you pointed me to a comment
that only partially described what the limitations were. (I.e., it
described the "two packets or 1ms", but not how they related, nor how
they related to the "max of 2 64k packets outstanding" of the default
tcp_limit_output_bytes setting.)

 -George


[1]
http://marc.info/?i=<CAFLBxZYt7-v29ysm=f+5QMOw64_QhESjzj98udba+1cS-PfObA@mail.gmail.com>
