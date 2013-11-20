From: w@1wt.eu (Willy Tarreau)
Date: Wed, 20 Nov 2013 01:35:19 +0100
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <1384906129.8604.132.camel@edumazet-glaptop2.roam.corp.google.com>
References: <20131113072257.GB10591@1wt.eu> <20131117141940.GA18569@1wt.eu>
 <1384710098.8604.58.camel@edumazet-glaptop2.roam.corp.google.com>
 <87li0kkhzx.fsf@natisbad.org>
 <1384869194.8604.92.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119174323.GH913@1wt.eu>
 <1384885910.8604.110.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119184121.GN913@1wt.eu> <874n780wzc.fsf@natisbad.org>
 <1384906129.8604.132.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <20131120003519.GA22150@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 04:08:49PM -0800, Eric Dumazet wrote:
> On Wed, 2013-11-20 at 00:53 +0100, Arnaud Ebalard wrote:
> 
> > Anyway, I think if the thread keeps going on improving mvneta, I'll do
> > all additional tests from RAM and will stop polluting netdev w/ possible
> > sata/disk/fs issues.
> 
> ;)
> 
> Alternative would be to use netperf or iperf to not use disk at all
> and focus on TCP/network issues only.

Yes, that's for the same reason that I continue to use inject/httpterm
for such purposes :
  - httpterm uses tee()+splice() to send pre-built pages without copying ;
  - inject uses recv(MSG_TRUNC) to ack everything without copying.

Both of them are really interesting to test the hardware's capabilities
and to push components in the middle to their limits without causing too
much burden to the end points.

I don't know if either netperf or iperf can make use of this now, and
I've been used to my tools, but I should take a look again.

Cheers,
Willy
