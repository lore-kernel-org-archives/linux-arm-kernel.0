From: jgchunter@gmail.com (Jon Hunter)
Date: Tue, 28 Apr 2015 10:11:05 +0100
Subject: [PATCH v3] ARM: tegra: Correct which USB controller has the UTMI
 pad registers
In-Reply-To: <1428045671-2333-1-git-send-email-tomeu.vizoso@collabora.com>
References: <551D61A5.2010102@kapsi.fi>
 <1428045671-2333-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <553F4EA9.4000307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/03/2015 08:21 AM, Tomeu Vizoso wrote:
> It should be the first controller, not the second. The indexes of the
> usb resets were also wrong and have been fixed.
> 
> The issue was caused by the changes in 308efde ("ARM: tegra: Add resets
> & has-utmi-pad-registers flag to all USB PHYs") being misapplied by git
> due to the patch context being insufficient.
> 
> This broke USB after 6261b06 ("regulator: Defer lookup of supply to
> regulator_get"), because it changed the order in which the controllers
> were probed.
> 
> The fix for this issue was suggested by Mikko Perttunen and Tuomas
> Tynkkynen.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> Cc: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
> Hi,
> 
> hope I have gotten it right this time, but please do check :)

FWIW, this works for me.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
