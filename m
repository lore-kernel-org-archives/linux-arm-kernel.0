From: horms@verge.net.au (Simon Horman)
Date: Mon, 15 Apr 2013 12:58:05 +0900
Subject: [PATCH v4 7/7] ARM: mach-shmobile: r8a7740: Setup the timer
 CMT10 using DT
In-Reply-To: <CABYn4szS=dLwQbnWe4rY==yomeefoLc7NNCR+KfM8pO3L5ihmQ@mail.gmail.com>
References: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
 <1365679443-25456-7-git-send-email-hechtb+renesas@gmail.com>
 <20130412012350.GA25941@verge.net.au>
 <CABYn4szS=dLwQbnWe4rY==yomeefoLc7NNCR+KfM8pO3L5ihmQ@mail.gmail.com>
Message-ID: <20130415035805.GE3070@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 02:46:15PM +0200, Bastian Hecht wrote:
> Hello Simon,
> 
> 2013/4/12 Simon Horman <horms@verge.net.au>:
> > On Thu, Apr 11, 2013 at 01:24:03PM +0200, Bastian Hecht wrote:
> >> We can now use the Device Tree for bringing up our timer device CMT10 on
> >> the SoC r8a7740.
> >
> > Hi Bastian,
> >
> > unfortunately with this patch the armaillo800eva no longer boots.
> >
> > I am testing  against renesas-next-20130411v2 with the other
> > 6 patches in this series applied. I am using the armadillo800eva defconfig.
> > The boot log is below.
> 
> Ouch, sorry! I checked the patches and somehow I missed a chunk in
> 0007-... when I rebased the series to next. The part that actually
> adds the DT info to r8a7740.dtsi. Further we need the GIC to be
> present in the DT to make things work here (my old patch used the
> INTCA as interrupt controller reference, but that has gone in the
> meantime).
> I want to repost my A1 reference code soon and in there I add the way
> to set up the GIC via DT.
> 
> To accelerate things maybe we take 0001-0006 now and postpone 0007
> until the GIC is in the DT?
> I diffed the new patches against the v3 series, and the .dtsi chunk is
> the only one that didn't make it, so I strongly believe the series is
> fine now.

Ok, thanks. I'll see about queuing-up 0001-0006 and you can repost
0007 at a later date.
