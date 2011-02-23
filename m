From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Feb 2011 09:13:59 -0800
Subject: Problem with "ARM: tegra: Move tegra_common_init to
	tegra_init_early"
In-Reply-To: <AANLkTimgw6kruGMp=wJUVka+Gj2cn9X=qRucbnuq-b9V@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF03112A5C22@HQMAIL01.nvidia.com>
	<AANLkTimgw6kruGMp=wJUVka+Gj2cn9X=qRucbnuq-b9V@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03112A5CD6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross wrote at Wednesday, February 23, 2011 12:43 AM:
> 
> On Tue, Feb 22, 2011 at 7:12 PM, Stephen Warren wrote:
> > The following commit makes the Tegra APB DMA engine fail to initialize
> > correctly:
> >
> > ARM: tegra: Move tegra_common_init to tegra_init_early
> > ...
> > I tried moving the call to tegra_dma_init back to each of the very end
> > of tegra_init_irq and the very beginning of tegra_harmony_init. Both
> > of these resulted in a kernel that wouldn't boot.
>
> I don't know why it still fails if you put it back at the beginning of
> the machine init, and it boots without errors on my board if I move
> tegra_dma_init to a postcore_initcall, but I don't have any drivers on
> my board that use DMA.

It looks like the fail-to-boot symptom was an operator error or
incremental build problem. I retested everything with a from-scratch
build and moving tegra_dma_int to be a postcore_initcall solves the issue
for me; I've posted a patch to do that.

-- 
nvpublic
