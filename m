From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Sep 2012 07:07:42 -0400
Subject: [PATCH 02/34] ASoC: mx27vis: retrieve gpio numbers from
 platform_data
In-Reply-To: <1347860103-4141-3-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120917110741.GD5401@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 01:34:31PM +0800, Shawn Guo wrote:

I've applied this since Javier says it fixes a bug but I'm not terribly
enthused about it.

>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   42 ++++++++++++++++++++++++++-
>  include/linux/platform_data/asoc-mx27vis.h  |   11 +++++++
>  sound/soc/fsl/mx27vis-aic32x4.c             |   42 +++++++++++++--------------

Audio drivers put their platform data in include/sound.

>  3 files changed, 72 insertions(+), 23 deletions(-)

This also seems like we're just going to be going for bloat, given that
this is a general change we should be (finally) getting round to having
a generic GPIO based CODEC driver.
