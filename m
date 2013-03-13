From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 13 Mar 2013 12:57:34 +0800
Subject: [PATCH V2 9/9] ARM: dts: tegra: add the PM configurations of PMC
In-Reply-To: <513FFD12.8050007@wwwdotorg.org>
References: <1363061043-9680-1-git-send-email-josephl@nvidia.com>
 <97395805.p014F9TUYL@fb07-iapwap2.physik.uni-giessen.de>
 <1363142623.3998.33.camel@jlo-ubuntu-64.nvidia.com>
 <513FFD12.8050007@wwwdotorg.org>
Message-ID: <1363150654.3998.103.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 12:14 +0800, Stephen Warren wrote:
> On 03/12/2013 08:43 PM, Joseph Lo wrote:
> > Hi Marc,
> > 
> > On Tue, 2013-03-12 at 18:43 +0800, Marc Dietrich wrote:
> >> Am Dienstag, 12. M?rz 2013, 12:04:03 schrieb Joseph Lo:
> >>> Adding the PM configuration of PMC when the platform support suspend
> >>> function.
> 
> >>> +		nvidia,core-pwr-good-time = <3845 3845>;
> >>
> >> mmh, no idea here. original source [1] shows 0x7e7e ticks which translates to 
> >> 1 sec?
> >>
> > The ticks was based on the 32KHz clock domain. I translate it to uS.
> 
> >>> 0x7e7e * (1.0/32000) * 1000000
> 1011937.4999999999
> 
> Oh, I suppose perhaps the 0x7e7e value is both values packed together,
> so this should be:
> 
> >>> 0x7e * (1.0/32000) * 1000000
> 3937.5
Yes.

0x7e * (1.0/32768) * 1000000 = 3845

Thanks,
Joseph
