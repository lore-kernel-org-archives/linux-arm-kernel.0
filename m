From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 10:14:15 +0100
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <CAAVeFu+UMZikdWO20c9chvBcieOAUgOhz-nTEUpevFWnPNC_ZA@mail.gmail.com>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
 <51B0BC80.9040007@wwwdotorg.org>
 <CAAVeFu+by44HnOzv_85kwgeCx5b9TxiMhr27x69QcUj9GRbk8A@mail.gmail.com>
 <51B20B46.4030501@wwwdotorg.org>
 <CAAVeFu+UMZikdWO20c9chvBcieOAUgOhz-nTEUpevFWnPNC_ZA@mail.gmail.com>
Message-ID: <20130610091415.GS18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 05:11:15PM +0900, Alexandre Courbot wrote:
> On Sat, Jun 8, 2013 at 1:33 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >>> I think we need to separate the concept of support for *a* secure
> >>> monitor, from support for a *particular* secure monitor.
> >>
> >> Agreed. In this case, can we assume that support for a specific secure
> >> monitor is not arch-specific, and that this patch should be moved
> >> outside of arch-tegra and down to arch/arm? In other words, the ABI of
> >> a particular secure monitor should be the same no matter the chip,
> >> shouldn't it?
> >
> > I would like to believe that the Trusted Foundations monitor had the
> > same ABI irrespective of which Soc it was running on. However, I have
> > absolutely no idea at all if that's true. Even if there's some common
> > subset of the ABI that is identical across all SoCs, I wouldn't be too
> > surprised if there were custom extensions for each different SoC, or
> > just perhaps even each product.
> >
> > Can you research this and find out the answer?
> 
> Will do. Information about TF is scarce unfortunately.

The answer is... there isn't a common ABI.  That is something I pressed
ARM Ltd for when this stuff first appeared and they were adamant that
they were not going to specify any kind of ABI for this interface.

The net result is that everyone has invented their own interfaces around
it.  Some pass all arguments in registers, some pass arguments in memory
and pass pointers to those memory locations, and those memory locations
have to be flushed in some way.
