From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 08 Feb 2013 21:40:24 +0000
Subject: [PATCH 1/2] ARM: DT: tegra: Add Tegra30 Beaver board support
In-Reply-To: <50E478AF.2040406@nvidia.com>
References: <1356032489-27619-1-git-send-email-pengw@nvidia.com>
 <50DDC743.2080606@gmail.com> <50DE3146.6090001@nvidia.com>
 <CAOesGMgW890K4Wo2-SFE4YFn5f8T950BTZ82rkCQfwpV+bsRyQ@mail.gmail.com>
 <50E478AF.2040406@nvidia.com>
Message-ID: <20130208214024.9467E3E2C27@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Jan 2013 10:13:03 -0800, Peng Wu <pengw@nvidia.com> wrote:
> On 12/28/2012 08:43 PM, Olof Johansson wrote:
> > On Fri, Dec 28, 2012 at 3:54 PM, Stephen Warren <swarren@nvidia.com> wrote:
> >> On 12/28/2012 09:22 AM, Rob Herring wrote:
> >>> On 12/20/2012 01:41 PM, Bryan Wu wrote:
> >>>> This patch adds support for Tegra30 Beaver board in upstream kernel.
> >>>> diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
> >>>> +/ {
> >>>> +    model = "NVIDIA Tegra30 Beaver evaluation board";
> >>>> +    compatible = "nvidia,beaver", "nvidia,tegra30";
> >>> nvidia,beaver needs to be documented.
> >> Hmmm. I guess we've managed not to document /any/ of the Tegra
> >> board-level compatible values. Bryan, could you make a separate patch to
> >> add all the existing board compatible values to
> >> Documentation/devicetree/bindings/arm/tegra.txt. The Beaver addition to
> >> that file can still be part of the Beaver-specific patch though.
> > Does it need to be documented? Then the "support a new platform only
> > through DTS update" is no longer true. :)
> >
> > In the past, I don't think we've strictly documented all derivative
> > platform compatible values, just some of the reference ones?
> >
> >
> > -Olof
> 
> Actually in every Tegra board dts file, there is a model string to 
> describe this machine as well as a compatible board string, just like 
> the "nvidia,beaver". So do we still need put this duplicated information 
> in a document file? Or if this is the requirement of DeviceTree. I will 
> do that. I think we have 12 boards need to add such document currently.

The model string is intended to be human-friendly, where as compatible
is primarily the matching mechanism.

I don't think it is stricly necessary to document top level compatible
strings unless there is something quirky that begs to be documented.
