From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Apr 2016 16:33:45 +0530
Subject: [PATCH] ARM: DTS: da850: fixed missing #gpio-cells in gpio node
In-Reply-To: <1459848697-21006-1-git-send-email-petr@barix.com>
References: <1459848697-21006-1-git-send-email-petr@barix.com>
Message-ID: <57063E91.9010106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

On Tuesday 05 April 2016 03:01 PM, Petr Kulhavy wrote:
> The gpio node was missing the mandatory property #gpio-cells, which was
> causing runtime errors when using GPIOs e.g. with gpio-leds or gpio-keys:
> 
> "could not get #gpio-cells for /soc/gpio at 1e26000"
> 
> This fixes the problem and adds the missing parameter.
> The value is 2 according to the gpio-davinci.txt binding.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>

Thanks for the patch. Queuing this for v4.7 since it has been this way
since beginning and there seem to be no in-kernel device-tree files with
a gpio consumerm, so no one seems to be immediately affected.

Thanks,
Sekhar
