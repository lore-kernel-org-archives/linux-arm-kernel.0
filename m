From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Apr 2015 18:35:58 +0100
Subject: [PATCH v7 1/9] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <5519E2B6.2030905@samsung.com>
References: <1426637856-3730-1-git-send-email-cw00.choi@samsung.com>
 <1426637856-3730-2-git-send-email-cw00.choi@samsung.com>
 <20150330160940.GA13731@leverpostej> <5519E2B6.2030905@samsung.com>
Message-ID: <20150402173558.GB30669@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 12:56:38AM +0100, Chanwoo Choi wrote:
> Hi Mark,
> 
> On 03/31/2015 01:09 AM, Mark Rutland wrote:
> > Hi,
> > 
> > On Wed, Mar 18, 2015 at 12:17:28AM +0000, Chanwoo Choi wrote:
> >> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
> >> Octal core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
> >> PSCI (Power State Coordination Interface) v0.1.
> >>
> >> This patch includes following dt node to support Exynos5433 SoC:
> >> 1. Octa core for big.LITTLE architecture
> >> - Cortex-A53 LITTLE Quad-core
> >> - Cortex-A57 big Quad-core
> >> - Support PSCI v0.1
> > 
> > Is CPU0 hotplug still broken, or has the FW been fixed?
> 
> CPU0 hotplug is still not working.
> 
> > 
> > I'm very worried about adding a DT that's known broken, especially when
> > we have no idea as to if/when the FW will be fixed judging from prior
> > replies.
> 
> As I replied, I can not fix the FW because I don't have any code of FW.

Surely you are able to contact those who do?

> I don't have any solution to fix it on Linux kernel level.
> 
> So, If you agree, I can add the comment of CPU0 hotplug issue on DT file.

I disagree. I do not want to add a DT that is known to be broken;
especially when we have no idea how to fix it. It creates long-term
maintenance pain for everyone, and marginal gain for few. A comment does
nothing to aid the end-user.

So NAK to the PSCI node and PSCI enable method in this dts until we
either have a working firmware, or a reasonable mechanism to handle the
deficiency.

Mark.
