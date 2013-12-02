From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Dec 2013 10:01:46 +0100
Subject: [PATCH 04/31] ARM: tegra: update DT files to add reset properties
In-Reply-To: <529B8ABB.5040109@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-5-git-send-email-swarren@wwwdotorg.org>
 <20131129130031.GQ22771@ulmo.nvidia.com>
 <529B8ABB.5040109@wwwdotorg.org>
Message-ID: <20131202090145.GB17834@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 01, 2013 at 12:15:07PM -0700, Stephen Warren wrote:
> On 11/29/2013 06:00 AM, Thierry Reding wrote:
> > On Fri, Nov 15, 2013 at 01:53:59PM -0700, Stephen Warren wrote: 
[...]
> >> reg = <0x70080300 0x100>; nvidia,ahub-cif-ids = <4 4>; clocks =
> >> <&tegra_car TEGRA114_CLK_I2S0>;
> > 
> > The clocks for these i2s devices are already listed in the ahub
> > node. Is that on purpose?
> 
> Yes.
> 
> The AHUB driver needs to remove reset from the HW modules, so that the
> configlink bus works. Reset removal used to require a custom Tegra API
> that took a clock as a parameter. Hence, the AHUB node needed the
> clock reference. After this series, the AHUB only needs a reset handle
> to use the standard reset API. However, the clock references are left
> in the AHUB node until after the AHUB driver is converted, so the
> series is bisectable. After the series, only the I2S driver needs to
> clock references.
[...]
> >> +			 <&tegra_car 30>,  /* i2s0 */ +			 <&tegra_car 11>,  /* i2s1
> >> */ +			 <&tegra_car 18>,  /* i2s2 */ +			 <&tegra_car 101>, /*
> >> i2s3 */ +			 <&tegra_car 102>, /* i2s4 */
> > 
> > Some comment for these as for Tegra20.
> 
> I'm not sure which other comment was "for Tegra20", since none of the
> filenames were quoted, but I'll try to check when I get back.

Indeed. I didn't quote the filenames. =( And I typoed Tegra114 as
Tegra20. I was referring to the "I2S clocks are listed in both the AHUB
and I2S nodes" comment above for Tegra114. From your earlier reply,
though this looks good then.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/8d805519/attachment.sig>
