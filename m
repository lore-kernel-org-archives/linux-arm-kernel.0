From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 27 Feb 2013 07:10:40 +0000
Subject: [PATCH v4 0/3] ASoC davinci/tlv320aic3x updates, fixes & DT
 support
In-Reply-To: <1359636786-7056-1-git-send-email-gururaja.hebbar@ti.com>
References: <1359636786-7056-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB76CE8@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Jan 31, 2013 at 18:23:03, Hebbar, Gururaja wrote:
> 1. Convert tlv320aic3x mic bias to a supply widget and related machine driver
> 2. Add DT support for Davinci machine platform
> 3. Remove __dev* attributes
> 
> This patch-set is tested on Davinci platform (DA850 EVM). This series applies on
> top of tag next-20130128 git tree
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> These patches cannot be tested directly on mainline kernel (DT based).
> This is because dma is not yet completely ported to Davinci ASoC. I had to add
> few hacks to get Audio working on Davinci DA850 platform.
> 
> For reference, I have placed the entire working tree @
> Tree :  https://github.com/ghebbar/linux.git
> Branch : dev_next-20130128_davinci_asoc_dt_v3

Only one patch out of the 3 is accepted.  I haven't received any review comments
from anyone for the other 2.

Kindly let me know if any further changes are required in the remaining changes 
or if I have missed any of comments.

If not, Could you please accept the remaining patch?

Remaining patches
ASoC: davinci: remove __dev* attributes [1]
ASoC: davinci: machine: Add device tree binding [2]


[1]
http://lkml.org/lkml/2013/1/31/243


[2]
http://lkml.org/lkml/2013/1/31/244


Regards, 
Gururaja

> 
> Changes in v4
> 	 - updated pending machine driver to change in micbias -> supply widget
> 	 - merge codec & machine driver change into a single commit
> 
> Changes in v3
> 	- drop mcasp pinctrl handler patch from series as it is now handled
> 	  centrally.
> 	- Convert tlv320aic3x mic bias to a supply widget and related machine
> 	  driver
> 	- remove __dev* attributes
> 
> Changes in v2
> 	 - Remove reference to Linux & software details from DT binding
> 
> Hebbar Gururaja (2):
>   ASoC: tlv320aic3x: Convert mic bias to a supply widget
>   ASoC: davinci: remove __dev* attributes
> 
> Hebbar, Gururaja (1):
>   ASoC: davinci: machine: Add device tree binding
> 
>  .../bindings/sound/davinci-evm-audio.txt           |   53 ++++++
>  .../devicetree/bindings/sound/tlv320aic3x.txt      |    6 +
>  include/sound/tlv320aic3x.h                        |   10 ++
>  sound/soc/codecs/tlv320aic3x.c                     |   83 ++++++++-
>  sound/soc/codecs/tlv320aic3x.h                     |    4 +
>  sound/soc/davinci/davinci-evm.c                    |  185 +++++++++++++++++---
>  sound/soc/omap/n810.c                              |    4 +-
>  sound/soc/omap/rx51.c                              |    8 +-
>  8 files changed, 318 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
> 
> -- 
> 1.7.9.5
> 
> 
