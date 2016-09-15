From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 15 Sep 2016 08:01:39 +0100
Subject: [PATCH 00/19] [RESEND] Remove STiH415 and STiH416 SoC platform
 support
In-Reply-To: <7524458.uFhxDUCqEo@wuerfel>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <7524458.uFhxDUCqEo@wuerfel>
Message-ID: <20160915070139.GA14319@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, 14 Sep 2016, Arnd Bergmann wrote:

> On Wednesday, September 14, 2016 2:27:38 PM CEST Peter Griffin wrote:
> > Resending due to incorrect Cc tags.
> > 
> > ST have sent patches which remove clock support for these SoCs [1]
> > which once applied mean the platform will no longer boot.
> > 
> > This series cleans up various STi platform drivers which have
> > support for these SoC's, by removing code, and updating the DT
> > documentation accordingly. Some drivers such as miphy365 and
> > stih41x-usb can be removed completely because the IP is only
> > found on these legacy SoC's.
> > 
> > Once this series is applied, drm display driver, and ALSA SoC
> > are the main two remaining references to the legacy SoCs, other
> > than clocks which already have patches on the ML.
> 
> It would be good to have a better explanation that "it's already
> broken by some other commit". Is this a platform that never shipped
> to end-users, or is it possible that someone out there actually
> has a machine with one of these SoCs?

STiH415 I'm sure never shipped. I'm reasonably sure STiH416 didn't
either. These SoCs were considered legacy even when I was at ST
~3 years ago.

Also remember these are STB SoC's, so JTAG fuses are blown in
production boxes, and also full security is enabled. This means the
primary bootloader will only boot a signed kernel. So if a end user
did happen to have a box they would be unable to upgrade their kernel.

>From the landing team perspective they were interesting in that they
shared many IPs with the STiH407 family on which future chipsets were
based, and were available to us when that silicon was harder to get
hold of. So we used it as a vehicle for upstreaming so that upstream
support was already quite good when STiH407 silicon did land on our
desk.

regards,

Peter.
