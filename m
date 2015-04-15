From: rick.jones2@hp.com (Rick Jones)
Date: Wed, 15 Apr 2015 13:08:59 -0700
Subject: [Xen-devel] "tcp: refine TSO autosizing" causes performance
 regression on Xen
In-Reply-To: <1429122734.7346.141.camel@edumazet-glaptop2.roam.corp.google.com>
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
 <552EA604.8010400@hp.com>
 <1429121303.7346.126.camel@edumazet-glaptop2.roam.corp.google.com>
 <552EABA3.30109@hp.com>
 <1429122734.7346.141.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <552EC55B.8020907@hp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2015 11:32 AM, Eric Dumazet wrote:
> On Wed, 2015-04-15 at 11:19 -0700, Rick Jones wrote:
>
>> Well, I'm not sure that it is George and Jonathan themselves who don't
>> want to change a sysctl, but the customers who would have to tweak that
>> in their VMs?
>
> Keep in mind some VM users install custom qdisc, or even custom TCP
> sysctls.

That could very well be, though I confess I've not seen that happening 
in my little corner of the cloud.  They tend to want to launch the VM 
and go.  Some of the more advanced/sophisticated ones might tweak a few 
things but my (admittedly limited) experience has been they are few in 
number.  They just expect it to work "out of the box" (to the extent one 
can use that phrase still).

It's kind of ironic - go back to the (early) 1990s when NICs generated a 
completion interrupt for every individual tx completion (and incoming 
packet) and all everyone wanted to do was coalesce/avoid interrupts.  I 
guess that has gone rather far.  And today to fight bufferbloat TCP gets 
tweaked to favor quick tx completions.  Call it cycles, or pendulums or 
whatever I guess.

I wonder just how consistent tx completion timings are for a VM so a 
virtio_net or whatnot in the VM can pick a per-device setting to 
advertise to TCP?  Hopefully, full NIC emulation is no longer a thing 
and VMs "universally" use a virtual NIC interface. At least in my little 
corner of the cloud, emulated NICs are gone, and good riddance.

rick
