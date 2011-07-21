From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 21 Jul 2011 08:33:31 -0700
Subject: [PATCH v2] ARM: Tegra: Trimslice: Tri-state DAP3 pinmux
In-Reply-To: <CABpLfohhtux1S6eJg+U7kgckw4j2vhMuWo8mBRaMpoZr5PuBiA@mail.gmail.com>
References: <1310596967-19996-1-git-send-email-swarren@nvidia.com>
	<CABpLfohE+PmssbicDjS3p13i=T4X5dZ=P-KhXmytvPX2An62=w@mail.gmail.com>
	<CABpLfohhtux1S6eJg+U7kgckw4j2vhMuWo8mBRaMpoZr5PuBiA@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF13B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Rapoport wrote at Thursday, July 21, 2011 3:17 AM:
> On Thu, Jul 21, 2011 at 10:10 AM, Mike Rapoport <mike.rapoport@gmail.com> wrote:
> >> DAP3 is used for a bunch of GPIOs. Not tri-stating the pins means audio
> >> signals get sent out there, and this ends up resetting USB and breaking
> >> SDHCI too.
> >>
> >> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> >> ---
> >> v2: s/DAP2/DAP3/ in patch subject/description.
> >
> > Setting DAP3 pins to tristate is necessary but not sufficient :) I
> > don't know why, but if we don't tristate DAP2 and DAP4 as well USB and
> > SDIO are broken.
> > If you can amend your patch with tristating also DAP2 and DAP4 feel
> > free to add my
> 
> Oops, I should have read the diff context as well... DAP{2,4} are
> anyway tristate, so you can discard my previous comment. So the
> Acked-by applies to the original patch. Sorry for the noise.
> 
> > Acked-by: Mike Rapoport <mike@compulab.co.il>

Thanks! Note that Arnd already picked this patch up in arm-soc.git.

-- 
nvpublic
