From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 24 Aug 2011 17:48:27 +0530
Subject: [PATCH 2/3] ARM: OMAP: Move omap2_init_common_devices out of
	init_early
In-Reply-To: <4E54EA5E.8010603@ti.com>
References: <20110824115048.2985.24230.stgit@kaulin>
	<20110824115433.2985.98712.stgit@kaulin> <4E54EA5E.8010603@ti.com>
Message-ID: <4E54EC13.6040509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 August 2011 05:41 PM, Cousson, Benoit wrote:
> Hi Tony,
>
> On 8/24/2011 1:54 PM, Tony Lindgren wrote:
>> There's no need to call omap2_init_common_devices from init_early.
>> It reprograms the memory timings for some boards, so it's better to
>> do it later so we have a chance to get console messages if something
>> goes wrong.
>
> BTW, I did some comment on that function in my OMAP4 device-tree series,
> because the name is misleading.
> That function is just initializing the SDRC controller present in OMAP2
> & 3. OMAP4 platform should not even call it.
> In fact, I'm now wondering were the OMAP4 EMIF is configured?
>
In the boot-loader at this point of time. EMIF driver should
make the configuration in kernel which is work in progress.

> void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
> struct omap_sdrc_params *sdrc_cs1)
> {
> if (cpu_is_omap24xx() || omap3_has_sdrc()) {
> omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
> _omap2_init_reprogram_sdrc();
> }
> }
>
> I guess it used to do much more than that in the past.
>
> Shouldn't we rename it to clarify its purpose?
>
I agree.

Regards
Santosh
