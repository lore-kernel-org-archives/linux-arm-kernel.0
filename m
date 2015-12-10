From: peda@axentia.se (Peter Rosin)
Date: Thu, 10 Dec 2015 15:29:37 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <20151210002213.GL8644@n2100.arm.linux.org.uk>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
 <20151203110041.GK8644@n2100.arm.linux.org.uk>
 <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
 <20151203115143.GM8644@n2100.arm.linux.org.uk>
 <533b0f1f264e42e78b94bbff9570fb50@EMAIL.axentia.se>
 <20151203133727.GN8644@n2100.arm.linux.org.uk>
 <94580382ca344ae2b64f66fb778c6ff7@EMAIL.axentia.se>
 <20151203164118.GR8644@n2100.arm.linux.org.uk>
 <20151203172708.GT8644@n2100.arm.linux.org.uk>
 <45b615420548463ebd1d582bc5da2eff@EMAIL.axentia.se>
 <20151210002213.GL8644@n2100.arm.linux.org.uk>
Message-ID: <7e60a8ccde1940d68ec4780abe154cbd@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> On Thu, Dec 03, 2015 at 09:37:51PM +0000, Peter Rosin wrote:
> > I took both patches for a quick spin (a dozen boots and one hour uptime
> > after that for each patch) and no incidents. I have not gathered data,
> > but the crash on boot feels like it's quite a bit above 50% when there
> > is a problem so this feels good (I used 5 clean reboots when I bisected
> > and that worked).
> > 
> > Reported-by: Peter Rosin <peda@axentia.se>
> > Tested-by: Peter Rosin <peda@axentia.se>
> > 
> > (and please don't forget to cc stable)
> 
> I've decided to do a more in-depth fix, so that we also solve the issue
> that when we schedule in these down_read()s, we don't leak the permissive
> domain register setting into the switched-to context.
> 
> Can you test this patch please?  Thanks.

Still looking good.

Cheers,
Peter
