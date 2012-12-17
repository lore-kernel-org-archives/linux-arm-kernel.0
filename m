From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Dec 2012 15:13:48 +0000
Subject: ARM realview breakages w/ 3.7 under qemu
In-Reply-To: <50CF26D2.1040008@openwrt.org>
References: <50CA0FC1.5090009@openwrt.org>
 <20121213174817.GB12946@mudshark.cambridge.arm.com>
 <20121214094012.GG14363@n2100.arm.linux.org.uk>
 <50CB0150.1000901@openwrt.org>
 <20121217134246.GE11558@mudshark.cambridge.arm.com>
 <50CF26D2.1040008@openwrt.org>
Message-ID: <20121217151348.GC22633@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 02:06:10PM +0000, Florian Fainelli wrote:
> Le 12/17/12 14:42, Will Deacon a ?crit :
> > On Fri, Dec 14, 2012 at 10:37:04AM +0000, Florian Fainelli wrote:
> >> Le 12/14/12 10:40, Russell King - ARM Linux a ?crit :
> >>> On Thu, Dec 13, 2012 at 05:48:17PM +0000, Will Deacon wrote:
> >>>> On Thu, Dec 13, 2012 at 05:26:25PM +0000, Florian Fainelli wrote:
> >>>>> - PBX A9: booting with less than 1024MBytes of RAM causes this:
> >>>>> [    0.000000] Truncating RAM at 20000000-3fffffff to -3f7fffff (vmalloc
> >>>>> region overlap).
> >>>>> [    0.000000] Ignoring RAM at 80000000-8fffffff (vmalloc region overlap).
> >>>>>
> >>>>> Do these issues sounds familiar to any of you? The kernel config is
> >>>>> attached in case that helps.
> >>> I don't have the original email to reply to (so I don't have the .config
> >>> either) but my guess for the above would be that HIGHMEM is disabled.
> >> The original mail containing the .config file was actually rejected by
> >> the mailing-list manager. I have uploaded it here:
> >> http://alphacore.org/~florian/openwrt/realview-eb-config
> >>
> >> You are right, HIGHMEM is disabled. Even though enabling HIGHMEM does
> >> not allow me booting either without at least 1Gbyte of RAM:
> >>
> >> [    0.000000] Memory policy: ECC disabled, Data cache writealloc
> >> and we are stuck.
> > I just dusted off my pbx and it boots fine with your .config and a 3.7
> > kernel when passing mem=128M on the command line.
> Ok, there must be something specific to qemu, can you also try with it?

Works too, but I had to add mem=128M to the command line (I guess the ATAGs
are wrong).

> >
> > For EB, can you try the following diff please?
> 
> Works for me, thank you! I realized that I had this patch for 3.3 
> already, but not in 3.7. This means that Realview EB has been broken 
> since 3.3-rc and specifically commit 34ae6c96 (ARM: 7298/1: realview: 
> fix mapping of MPCore private memory region).

Cool, can I re-post with your tested-by please?

Will
