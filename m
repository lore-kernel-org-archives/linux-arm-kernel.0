From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 1 Oct 2018 17:45:45 +0200
Subject: [PATCH v2] ARM: dts: sun8i-h3: add sy8106a to orange pi plus
In-Reply-To: <20180929131830.13924-1-jorik@kippendief.biz>
References: <20180929131830.13924-1-jorik@kippendief.biz>
Message-ID: <20181001154545.iwxjgw5exg4psfy4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2018 at 03:18:30PM +0200, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
> 
> The Orange Pi Plus board lacks voltage scaling capabilities in its
> current form. This results in random freezes during boot when cpufreq is
> enabled, probably due to wrong voltages.
> 
> This patch (more or less copy/paste from 06139c) does the following
> things on this board:
> - enable r_i2c
> - add sy8106a to the r_i2c bus
> - have the sy8106a regulate VDD of cpu
> 
> Since the Orange Pi Plus has the same PMU setup as the Orange Pi PC, I
> simply took min/max/fixed/ramp from the latter DTS. In that file the
> origin of the values are described by the following comment:
> 
>   "The datasheet uses 1.1V as the minimum value of VDD-CPUX,
>   however both the Armbian DVFS table and the official one
>   have operating points with voltage under 1.1V, and both
>   DVFS table are known to work properly at the lowest
>   operating point.
>   Use 1.0V as the minimum voltage instead."
> 
> I have tested this on patch two Orange Pi Plus boards, by running a
> kernel with this patch and do intermettent runs of cpuburn while
> monitoring voltage, frequency and temperature. The board runs stable
> across its operatiing points while showing a reasonable (< 40C)
> temperature. My Orange Pi PC, when put to the same test, yields similar
> stable results.
> 
> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>

Queued for 4.21, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181001/9ce8cc3e/attachment.sig>
