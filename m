From: tj@kernel.org (Tejun Heo)
Date: Fri, 17 Mar 2017 10:13:13 -0400
Subject: [PATCH] pata_pcmcia: add EBSA110's PCMCIA slot support
In-Reply-To: <11380780.Ccg1NEX8q5@amdc3058>
References: <CGME20170314175046epcas1p43f98daad14a2bac7f314e7d39e120232@epcas1p4.samsung.com>
 <1533391.BtkrkgvqUW@amdc3058>
 <20170317133900.GA5078@htj.duckdns.org>
 <11380780.Ccg1NEX8q5@amdc3058>
Message-ID: <20170317141313.GC5078@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Mar 17, 2017 at 03:08:56PM +0100, Bartlomiej Zolnierkiewicz wrote:
> To be honest, the main point here is to make Russell happy. ;-)
> 
> This is the second time he brought EBSA110 issue while talking about
> conversion of ARM platforms to use libata PATA so I've finally decided
> to do the patch just to have a reference example of how to deal with
> this and similar devices in a proper way.
> 
> Even though the patch can't be tested EBSA110 is still a supported ARM
> platform and the patch should work fine in theory (+ it cannot break
> anything).  OTOH it adds an extra code which has some cost from the
> long-term maintenance POV.  Anyway, it is up to you to decide what to
> do with it. :-)

It's fairly low impact and I don't think it's gonna add noticeable
maintenance overhead at all, so that part is fine but it's super weird
to add code which we know not to have any users.  It looks like we
can't even test it.

What's the end game here?  Is it part of the effort to remove ide?  If
so, I have no objection to that but think it isn't a pressing issue
either and the ultimate decision has to come from Dave.

Thanks.

-- 
tejun
