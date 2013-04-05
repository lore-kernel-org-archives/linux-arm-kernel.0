From: horms@verge.net.au (Simon Horman)
Date: Fri, 5 Apr 2013 09:40:20 +0900
Subject: [PATCH v4 3/3] ARM: shmobile: kzm9g-reference: add CPUFreq support
In-Reply-To: <Pine.LNX.4.64.1304042352180.21548@axis700.grange>
References: <1364153255-20664-1-git-send-email-g.liakhovetski@gmx.de>
 <1364153255-20664-4-git-send-email-g.liakhovetski@gmx.de>
 <20130404043746.GD28297@verge.net.au>
 <Pine.LNX.4.64.1304042352180.21548@axis700.grange>
Message-ID: <20130405004020.GM29203@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 11:54:20PM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> Thanks for the review
> 
> On Thu, 4 Apr 2013, Simon Horman wrote:
> 
> > On Sun, Mar 24, 2013 at 08:27:35PM +0100, Guennadi Liakhovetski wrote:
> > > This patch enables the use of the generic cpufreq-cpu0 driver on kzm9g.
> > > Providing a regulator, a list of OPPs in DT, combined with a virtual
> > > cpufreq-cpu0 platform device and a clock, attached to it is everything,
> > > the cpufreq-cpu0 driver needs.
> > 
> > I wonder if it would be possible to re-arange this patch a little.
> > 
> > 1) vdd_dvfs is added in this patch but it appears to be used in the
> >    previous patch in the series. I wonder if this can be resolved
> >    by re-ordering the patches.
> 
> Right, I'll change that.
> 
> > 2) It includes both kzm9g board and sh73a0 SoC changes.
> >    I would prefer if the sh73a0 SoC portion (setup-sh73a0.c)
> >    was moved into a separate patch. The arm-soc people
> >    like to have separate board and SoC branches.
> 
> Yes, I'll probably just merge the sh73a0-kzm9g-reference.dts hunk into the 
> previous patch.

Thanks, I think that approach should work well.
