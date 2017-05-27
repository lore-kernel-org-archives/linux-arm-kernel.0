From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 May 2017 14:22:37 +0100
Subject: [CFT] Always enable SMP mode on MP capable CPUs
In-Reply-To: <20170526112210.GA3354@afzalpc>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
 <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
 <20170519171526.GW22219@n2100.armlinux.org.uk>
 <20170524153847.GY10472@atomide.com>
 <20170525144800.GV23750@n2100.armlinux.org.uk>
 <20170525151103.GC10472@atomide.com>
 <20170525180540.GW23750@n2100.armlinux.org.uk>
 <20170525221332.GE10472@atomide.com>
 <20170526112210.GA3354@afzalpc>
Message-ID: <20170527132237.GX23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 04:52:10PM +0530, afzal mohammed wrote:
> Hi,
> 
> On Thu, May 25, 2017 at 03:13:33PM -0700, Tony Lindgren wrote:
> 
> > OK so got my am437x-idk back
> > 
> > And as suspected it won't boot with these changes.
> 
> Tested here too with your additional changes included & seeing same
> behavior here as well on AM437x.
> 
> As an aside, when Russell posted this patch a week back itself was
> suspecting this. i had a certain view on AM437x w.r.t SMP issue back
> while officially working on it & since now not officially involved
> with the issue at hand, i was uncomfortable dealing with this. But as
> Russell's patch was not noticed by others w.r.t AM437x, upon being
> able to confirm it yesterday, i at least wanted to bring it to notice
> & runaway from the scene.

Right, so I think the summary is: the kernel can't set the SMP bit
correctly - it doesn't have the information at this point in time
to know definitively whether the bit needs to be set or not.

So, those who are suffering issues with their SMP cores in uniprocessor
systems need to ensure that their boot loader correctly configures the
CPU cores.

Thanks for testing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
