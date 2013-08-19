From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 Aug 2013 21:54:14 +0100
Subject: [PATCH v4 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <CAPdLdqk-7dfGK62Y0Og8vzJ9TUz_OAZv3AfFPUDJDy52tPVszQ@mail.gmail.com>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <2184179.Dja4tiYGvP@lenovo>
 <CAPdLdqk-7dfGK62Y0Og8vzJ9TUz_OAZv3AfFPUDJDy52tPVszQ@mail.gmail.com>
Message-ID: <1804309.Ypdt3FAFFr@lenovo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi 19 ao?t 2013 12:23:47 Markus Mayer a ?crit :
> On 19 August 2013 12:11, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > Le lundi 19 ao?t 2013 12:05:55 Markus Mayer a ?crit :
> >> On 19 August 2013 12:02, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >> > Hello Markus,
> >> > 
> >> > Le lundi 19 ao?t 2013 11:59:19 Markus Mayer a ?crit :
> >> >> From: Markus Mayer <mmayer@broadcom.com>
> >> >> 
> >> >> This patch adds the GPIO driver for the bcm281xx family of chips.
> >> >> 
> >> >> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> >> >> Reviewed-by: Christian Daudt <csd@broadcom.com>
> >> >> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> >> >> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> >> >> ---
> >> >> 
> >> >>  .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   43 ++
> >> > 
> >> > Since the vendor prefix has been changed from brcm to bcm, should that
> >> > also be reflected in the Device Tree binding documentation file?
> >> 
> >> Actually, it is the other way around. "brcm," was there first, but we
> >> overlooked that and started upstreaming code with the "bcm," vendor
> >> prefix. There are various patches floating around out there to change
> >> our use of "bcm," to "brcm," to make it conform to the established
> >> vendor prefixes.
> > 
> > Ermm yes, I realized that after hitting send. Netherless, should this be
> > renamed to "gpio-brcm-kona.txt" directly such that the patches you mention
> > do not have to get updated to patch this one too?
> 
> After long discussions on how to handle the "bcm" vs. "brcm"
> situation, we said we would be renaming the "bcm," vendor prefixes to
> "brcm,", but would otherwise refrain from renaming files, variables,
> function names, etc. except if the file name contains the vendor
> prefix itself.
> 
> The thing is that Broadcom is exclusively using the BCM abbreviation
> internally. Except for our stock ticker, nothing is named "BRCM". :-)
> So, the less "brcm" is out there, the better it is. Unfortunately,
> it's too late for the vendor prefix.
> 
> I can see how a file called gpio-bcm-kona.txt talking about the
> "brcm," could be a bit confusing. It's still straight forward enough
> to find out that the definition of "brcm,kona-gpio" is in the
> gpio-bcm-kona.txt file. And the boundary of what's called "brcm" is
> still firm: just the vendor prefix.
> 
> But if we renamed it to gpio-brcm-kona.txt, then it would be confusing
> why there are not other files named *brcm* and the boundary of what is
> named how would become quite blurry.

I am happy with that explanation, thanks! That works for me too.
-- 
Florian
