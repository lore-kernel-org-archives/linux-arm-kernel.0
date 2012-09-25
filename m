From: scottwood@freescale.com (Scott Wood)
Date: Tue, 25 Sep 2012 14:35:46 -0500
Subject: [RFC PATCH 0/3] ARM: use C pre-processor with dtc
In-Reply-To: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org> (from
 swarren@wwwdotorg.org on Tue Sep 25 14:06:35 2012)
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1348601746.5565.18@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 02:06:35 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This series adds some build rules to run cpp on *.dts-cpp prior to
> invoking dtc, and converts Tegra to the new rule as an example. What  
> do
> people think?
> 
> I assume that you've applied the dtc patches I sent yesterday. They
> aren't in this series. See:
> 
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020182.html
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020183.html
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020181.html
> 
> Note: those patches are against upstream dtc. If you wish to test this
> series, apply the dtc patches to upstream dtc, build it, and copy the
> resultant dtc binary over the top of scripts/dtc/dtc.
> 
> Stephen Warren (3):
>   kbuild: introduce cmd_dtc_cpp
>   ARM: use cmd_dtc_cpp for compilation of *.dts-cpp to *.dtb
>   ARM: tegra: compile all DT files with cpp

Do you have an example of where you'd actually benefit from this?  I'd  
think most things could either be done reasonably well with what's  
built into DTC (see what we've done in arch/powerpc/boot/dts/fsl), or  
would need math expression support in DTC (or has that been added?).

-Scott
