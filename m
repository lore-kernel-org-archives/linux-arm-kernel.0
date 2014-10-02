From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Oct 2014 12:08:05 +0100
Subject: [PATCH] ARM: tegra: Move AHB Kconfig to drivers/amba
In-Reply-To: <20141002105103.GA13906@ulmo>
References: <1406643934-16301-1-git-send-email-thierry.reding@gmail.com>
 <53D7C9EE.60503@wwwdotorg.org> <53FB7288.9050002@wwwdotorg.org>
 <5408BF77.1020007@wwwdotorg.org> <20141002105103.GA13906@ulmo>
Message-ID: <20141002110805.GT5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 12:51:04PM +0200, Thierry Reding wrote:
> On Thu, Sep 04, 2014 at 01:37:27PM -0600, Stephen Warren wrote:
> > On 08/25/2014 11:29 AM, Stephen Warren wrote:
> > >On 07/29/2014 10:21 AM, Stephen Warren wrote:
> > >>On 07/29/2014 08:25 AM, Thierry Reding wrote:
> > >>>From: Thierry Reding <treding@nvidia.com>
> > >>>
> > >>>This will allow the Kconfig option to be shared among 32-bit and 64-bit
> > >>>ARM.
> > >>
> > >>This seems fine to me. I'd expect to apply it for 3.18, provided I get
> > >>an ack from Russell as drivers/amba maintainer (hence CCing him without
> > >>trimming the quote).
> > >
> > >Russell,
> > >
> > >Are you OK with this patch? If so, if you could ack it so I can apply
> > >it, that would be great.
> > 
> > Russell?
> 
> Russell,
> 
> Can I have your Acked-by on this or would you prefer it to be submitted
> to the patch tracker? Would the patch tracker be the correct place also
> for non-ARM core patches?

I just had to go digging for the original patch, as I've been missing
this.

I think this is fine, though if we're going to have drivers/amba/Kconfig,
we should also move the ARM_AMBA Kconfig option there too.  Note that it
currently appears in both arch/arm/Kconfig and arch/arm64/Kconfig.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
