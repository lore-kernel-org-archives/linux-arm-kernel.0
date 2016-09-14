From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 15:38:58 +0200
Subject: [PATCH 00/19] [RESEND] Remove STiH415 and STiH416 SoC platform
 support
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <7524458.uFhxDUCqEo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 14, 2016 2:27:38 PM CEST Peter Griffin wrote:
> Resending due to incorrect Cc tags.
> 
> ST have sent patches which remove clock support for these SoCs [1]
> which once applied mean the platform will no longer boot.
> 
> This series cleans up various STi platform drivers which have
> support for these SoC's, by removing code, and updating the DT
> documentation accordingly. Some drivers such as miphy365 and
> stih41x-usb can be removed completely because the IP is only
> found on these legacy SoC's.
> 
> Once this series is applied, drm display driver, and ALSA SoC
> are the main two remaining references to the legacy SoCs, other
> than clocks which already have patches on the ML.

It would be good to have a better explanation that "it's already
broken by some other commit". Is this a platform that never shipped
to end-users, or is it possible that someone out there actually
has a machine with one of these SoCs?

	Arnd
