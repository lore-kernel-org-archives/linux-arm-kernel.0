From: brian.austin@cirrus.com (Brian Austin)
Date: Tue, 29 Apr 2014 21:31:30 -0500
Subject: [alsa-devel] [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs depend
 on INPUT
In-Reply-To: <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
Message-ID: <alpine.DEB.2.02.1404292124270.31465@heelrod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 29 Apr 2014, Xia Kaixu wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Building ARM randconfig got into a situation where CONFIG_INPUT
> is turned off and SND_SOC_ALL_CODECS is turned on, which failed
> for two codecs trying to use the input subsystem. Some other
> drivers also select one of these codecs and consequently need an
> explicit dependency added.

I assume you mean the CS42L52 instead of the L51. INPUT is used for a BEEP 
Generator but when I disable CONFIG_INPUT I do not get an error. Is there 
any information available on what the error is?


>
> Appending to the dependency list seems the easiest way out,
> since this is not a practical limitation. If anyone really
> needs to build these codecs for a kernel with no input support,
> a more sophisticated solution can be implemented.
>
It shouldn't build the BEEP code without CONFIG_INPUT enabled as you can 
use the CODEC without the BEEP enabled.

I believe the WM8962 is done the same way.

Thanks,
Brian
