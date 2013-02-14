From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Feb 2013 09:03:33 -0800
Subject: [PATCH 0/9] ARM: tegra: use new dtc+cpp feature
In-Reply-To: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130214170333.GB7144@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130213 13:37]:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This series converts the Tegra device tree files to use the new feature
> of running cpp over .dts files before compiling them with dtc. This
> allows GPIOs and other GPIO/IRQ specifier cells to be named for example.
> 
> As far as merging goes, I'd anticipate the first 3 patches being useful
> to any other ARM sub-arch that wants to convert; perhaps they could go
> through some arm-soc common branch. The next 2 patches are Tegra-specific
> cleanup that I'd anticipate applying to Tegra's for-3.10/cleanup. The
> rest of the patches depend on those 5 previous patches, so would need to
> go into a Tegra branch that merges in the previous patches; I'd anticipate
> calling it for-3.10/dtc-cpp say.

Great! This will help a lot with making the .dts* files readable.
 
> One issue this raises: The first 2 patches aren't ARM-specific. I put the
> files they create into arch/arm/boot/dts, but I wonder if they wouldn't be
> better in some arch-agnostic include directory, or even right with the
> binding documentation in Documentation/devicetree/bindings. Moving the
> files would require adjusting the cpp include path.

I'd assume this will be used by many architectures, so it would probably
be a good idea to make them common to start with.

Regards,

Tony
