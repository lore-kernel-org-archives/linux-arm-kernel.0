From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 May 2016 16:12:08 +0100
Subject: [PATCH kexec-tools 12/32] kexec: add helper to exlude a region
 from a set of memory ranges
In-Reply-To: <CAHB_GuoRuQwhe-bXKAzmjOn=3=7KQ7LtT2JTooO1kjx+V3VgpQ@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSv-0004i3-Gi@e0050434b2927.dyn.arm.linux.org.uk>
 <CAHB_Guo_ozXhAnkGk_NrdBME2fSYDoKTHwu3kLBvsrmbwxOdww@mail.gmail.com>
 <20160526085638.GF19428@n2100.arm.linux.org.uk>
 <CAHB_GuoRuQwhe-bXKAzmjOn=3=7KQ7LtT2JTooO1kjx+V3VgpQ@mail.gmail.com>
Message-ID: <20160527151208.GO19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 08:37:41PM +0530, Pratyush Anand wrote:
> On Thu, May 26, 2016 at 2:26 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > -                               new = ranges->ranges + ranges->size++;
> > -                               new->start = range->end + 1;
> > -                               new->end = r->end;
> > +                               ret = mem_regions_add(ranges, range->end + 1,
> > +                                                     r->end, 0);
> 
> 3rd argument should be (r->end - range->end)

Yes indeed, thanks for pointing that out.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
