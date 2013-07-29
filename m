From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 29 Jul 2013 14:13:44 +0100
Subject: [PATCH v2 01/22] [HACK] of: dev_node has struct device pointer
In-Reply-To: <20130729.131344.1221933042559369096.hdoyu@nvidia.com>
References: <1373021097-32420-2-git-send-email-hdoyu@nvidia.com>
 <51E5CFBF.5080407@wwwdotorg.org>
 <20130716231629.GA12189@dhcp-172-17-186-34.nvidia.com>
 <20130729.131344.1221933042559369096.hdoyu@nvidia.com>
Message-ID: <20130729131344.GB6184@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hiroshi,

On Mon, Jul 29, 2013 at 11:13:44AM +0100, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding@gmail.com> wrote @ Wed, 17 Jul 2013 01:16:30 +0200:
> 
> > * PGP Signed by an unknown key
> > 
> > On Tue, Jul 16, 2013 at 04:57:03PM -0600, Stephen Warren wrote:
> > > On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > > > To prevent of_platform_populate() from trying to populate duplicate
> > > > devices if a device has been already populated.
> > > 
> > > You need to send drivers/of patches to the DT maintainer and
> > > devicetree-discuss mailing list.
> > > 
> > > > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > > > ---
> > > > Need to take care of early_platform_devices, or alternative solution.
> > > 
> > > I assume that's a TODO item... Are you planning on fleshing out this
> > > patch to address that issue?
> >
> > There was some more discussion about it, which can be found in the
> > following thread:
> > 
> > 	https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/036934.html
> > 
> > That's one of the last messages and it should have most of the
> > background. If not you may have to walk up the thread for more context.
> > In a nutshell I raised the question as to why we can't simply call
> > of_platform_populate() earlier and side-step all the workarounds that
> > have found their way into the kernel to side-step the issue of their not
> > being a struct device associated with the struct device_node.
> 
> This is the thread which Lorenzo started originally. He may have some
> plan to implement/proceed with this, Lorenzo?

I was trying to raise the issue and apparently I succeeded. For now,
I put in place yet-another-temporary-solution to the problem in one
of the drivers I need for power management, but certainly the problem is
not solved, and I can't allocate time to do it myself unfortunately.

I am more than happy to review patches though.

Thanks,
Lorenzo
