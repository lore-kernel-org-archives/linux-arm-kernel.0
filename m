From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 5 Oct 2011 08:55:25 -0700
Subject: [PATCH 2/3] mmc: Add OF bindings support for mmc host
	controller	capabilities
In-Reply-To: <CAJuYYwS_NeE6OG9X2p2rkjgo4OqO-ijeVwr1sLGkUuLJOxMw2g@mail.gmail.com>
References: <1317809581-28783-1-git-send-email-thomas.abraham@linaro.org>
	<1317809581-28783-3-git-send-email-thomas.abraham@linaro.org>
	<4E8C5BD6.2070709@gmail.com>
	<CAJuYYwS_NeE6OG9X2p2rkjgo4OqO-ijeVwr1sLGkUuLJOxMw2g@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173A2C7245@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote at Wednesday, October 05, 2011 8:28 AM:
> On 5 October 2011 18:59, Rob Herring <robherring2@gmail.com> wrote:
> > On 10/05/2011 05:13 AM, Thomas Abraham wrote:
> >> Device nodes representing sd/mmc controllers in a device tree would include
> >> mmc host controller capabilities. Add support for parsing of mmc host
> >> controller capabilities included in device nodes.
...
> >> +- linux,mmc_cap_4_bit_data - host can do 4 bit transfers
> >> +- linux,mmc_cap_mmc_highspeed - host can do MMC high-speed timing
> >> +- linux,mmc_cap_sd_highspeed - host can do SD high-speed timing
> >> +- linux,mmc_cap_needs_poll - host needs polling for card detection
> >> +- linux,mmc_cap_8_bit_data - host can do 8 bit transfer
> >
> > "sdhci,1-bit-only" already exists as a binding. Perhaps add
> > "sdhci,4-bit-only". No property then means can do 8-bit.
> 
> Ok. But that would remain just as sdhci host controller capability and
> will not be applicable to other types of host controllers.

Just as an FYI, NVIDIA's SDHCI controller bindings use property
"support-8bit" to indicate 8-bit support. A similar property could be
used for 4-bit support too.

-- 
nvpublic
