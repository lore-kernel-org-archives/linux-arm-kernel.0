From: Marc.Dietrich@ap.physik.uni-giessen.de (Marc Dietrich)
Date: Mon, 8 Aug 2011 23:15:15 +0200
Subject: [PATCH 4/5] ARM: tegra: paz00: add clocks required forusboperation
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049F1721DE@HQMAIL01.nvidia.com>
References: <cover.1312742856.git.marvin24@gmx.de>
	<201108081919.07647.marc.dietrich@ap.physik.uni-giessen.de>
	<74CDBE0F657A3D45AFBB94109FB122FF049F1721DE@HQMAIL01.nvidia.com>
Message-ID: <201108082315.16974.marc.dietrich@ap.physik.uni-giessen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag 08 August 2011, 19:38:25 schrieb Stephen Warren:
> Marc Dietrich wrote at Monday, August 08, 2011 11:19 AM:
> > On Monday 08 August 2011 18:57:52 Stephen Warren wrote:
> 
> +	{ "pll_p_out4", "pll_p",        24000000,       true },
> 
> Oh, and looking at the patches I recently posted to add USB support to
> Harmony and Seaboard, which have been in the ChromeOS kernel for a while,
> the USB clocks entries are typically e.g.:
> 
>         { "usbd",       "clk_m",        12000000,       true},
>         { "usb3",       "clk_m",        12000000,       true},
> 
> Our internal Android kernel uses the same parent/rate setup for Harmony
> too.
> 
> (there's a "usb2" too if you need; one per controller, so it depends which
> are used on the AC100)

Seems we are using all three ports (including fsl_udc for debugging). I left 
them out because they seem to be switched on automaticly (either via the 
bootloader or via the tegra-ehci driver).

On the other hand, we want to move to u-boot sooner or later so I think it's 
better to enable them now.

Marc
