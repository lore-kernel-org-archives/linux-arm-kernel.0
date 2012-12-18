From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 18 Dec 2012 01:50:12 +0100
Subject: [PATCH 3/3] ARM: Dove: add Cubox sdhci card detect gpio
In-Reply-To: <20121218003810.GP21694@titan.lakedaemon.net>
References: <1355790269-10596-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1355790269-10596-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20121218003810.GP21694@titan.lakedaemon.net>
Message-ID: <50CFBDC4.8040109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2012 01:38 AM, Jason Cooper wrote:
 > On Tue, Dec 18, 2012 at 01:24:29AM +0100, Sebastian Hesselbarth wrote:
 >> Card detect for sdhci on Cubox is connected to the wrong pin
 >> (sdio1_cd instead of sdio0_cd). With support for cd-gpios and
 >> pinctrl add the corresponding properties to DT for Cubox.
 >>
 >> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
 >> ...
 >> +&sdio0 {
 >> +	status = "okay";
 >> +	/* sdio0 card detect is connected to wrong pin on CuBox */
 >> +	cd-gpios =<&gpio0 12 1>;
 >
 > this looks like a fix that should be merged into v3.8, I'll cue it up
 > for v3.8-rc2.

Jason,

it is more a feature than a fix, as gpio-cd support for sdhci-dove
moved in lately. You want me to split this patch from the other two
(that I'll reorder as requested)?

Sebastian
