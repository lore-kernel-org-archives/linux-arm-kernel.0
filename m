From: robert.jarzmik@free.fr (robert.jarzmik at free.fr)
Date: Mon, 16 Feb 2015 14:27:28 +0100 (CET)
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <20150216130549.GF14545@x1>
Message-ID: <1170550770.470129293.1424093248596.JavaMail.root@zimbra1-e1.priv.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Mail original -----
De: "Lee Jones" <lee.jones@linaro.org>
?: "Robert Jarzmik" <robert.jarzmik@free.fr>
Cc: "Rob Herring" <robh+dt@kernel.org>, "Pawel Moll" <pawel.moll@arm.com>, "Mark Rutland" <mark.rutland@arm.com>, "Ian Campbell" <ijc+devicetree@hellion.org.uk>, "Kumar Gala" <galak@codeaurora.org>, "Daniel Mack" <daniel@zonque.org>, "Haojian Zhuang" <haojian.zhuang@gmail.com>, "Samuel Ortiz" <sameo@linux.intel.com>, "Grant Likely" <grant.likely@linaro.org>, devicetree at vger.kernel.org, linux-kernel at vger.kernel.org, linux-arm-kernel at lists.infradead.org, "Arnd Bergmann" <arnd@arndb.de>, "Russell King - ARM Linux" <linux@arm.linux.org.uk>, "Dmitry Eremin-Solenikov" <dbaryshkov@gmail.com>
Envoy?: Lundi 16 F?vrier 2015 14:05:49
Objet: Re: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board

On Sat, 24 Jan 2015, Robert Jarzmik wrote:

> ---
> Since v1: change the name from cottula to lubbock_io
>             Dmitry pointed out the Cottula was the pxa25x family name,
> 	    lubbock was the pxa25x development board name. Therefore the
> 	    name was changed to lubbock_io (lubbock IO board)

> Are you sure this is what you want to do?  We don't usually support
> 'boards' per say.  Instead we support 'devices', then pull each of
> those devices together using some h/w description mechanism.

Do you know that :
 1) anything under "---" in a commit message is thrown away
 2) after v2, we _both_ agreed that the accurate name is "cplds"
    which exactly what is in this patch
    (see device registering with lubbock_cplds).
 3) there is no more mention of "board" anywhere in the patch core

> Besides, this is MFD, where we support single pieces of silicon which
> happen to support multiple devices.  I definitely don't want to support
> boards here.
> You might want to re-think the naming and your (sales) pitch.
I might need help. As for the (sales), no comment.

>> +#include <linux/mfd/core.h>
> Why have you included this?  I don't see the use of the MFD framework
> anywhere.  So what makes this an MFD?
I thought cplds were to be handled by an MFD driver.

> I'm going to stop here, as I think I need more of an explanation so
> what you're trying to achieve with this driver.
Why ? I think things were clear that this driver handles the CPLDs on
lubbock board, namely u46 and u52. I don't understand what is wrong
with this patch so that you don't want to go forward.

--

Robert
