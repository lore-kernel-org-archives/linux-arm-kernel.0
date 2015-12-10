From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Dec 2015 11:35:41 +0000
Subject: [PATCH] cpufreq: tegra: add regulator dependency for T124
In-Reply-To: <56694EFA.7010901@nvidia.com>
References: <2194927.eV2s2QmZs0@wuerfel> <5668188F.2080202@nvidia.com>
 <20151209144734.GB5727@sirena.org.uk> <566865ED.3020106@nvidia.com>
 <20151209201007.GG5727@sirena.org.uk> <56694EFA.7010901@nvidia.com>
Message-ID: <20151210113541.GL5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 10:07:54AM +0000, Jon Hunter wrote:
> On 09/12/15 20:10, Mark Brown wrote:
> > On Wed, Dec 09, 2015 at 05:33:33PM +0000, Jon Hunter wrote:

> >> Yes, setting the frequency and voltage as defined by a given operating
> >> mode would make sense. However, I am not sure we have those defined in
> >> the kernel for this PLL and would have to be added.

> > I think given how you're describing the hardware that this will be
> > required in order to provide something robust (and also to get the best
> > power savings from the hardware).

> Yes I agree it would be more robust. However, if you care about power
> savings then you should be using the DFLL/cpufreq anyway.

Without knowing anything about the hardware this is all a bit confusing
I'm afraid.  What is "DFLL/cpufreq" as opposed to "the PLL"?

> From testing the t124 jetson and nyan-big, both of these boards have a
> different configuration for the PLL at boot time, so although we could
> pick a safe operating point for all t124 boards, I was thinking of just
> restoring their initial configuration.

This seems more complex, and also makes the idea of relying on the
initial configuration seem slightly concerning - other software seems to
be already changing the configuration before we get to the kernel so if
we don't fully understand the configuration we're doing we seem likely
to find some configuration where we miss things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151210/11858660/attachment-0001.sig>
