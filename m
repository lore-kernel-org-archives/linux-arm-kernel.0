From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Aug 2014 23:18:28 +0200
Subject: [PATCH v3 0/6] Add EHCI and OHCI drivers for STi SoC's
In-Reply-To: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
References: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <201408062318.28958.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 August 2014, Peter Griffin wrote:
> This series adds support for the OHCI and EHCI on-chip controllers
> found in STi consumer electronics SoC's from STMicroelectronics.
> 
> The series has been re-worked from v2 to split out the ehci and ohci parts
> into their own drivers / devices like most other ARM platforms based on
> feedback from Arnd Bergmann (see here http://www.spinics.net/lists/linux-usb/msg111124.html. 
> 
> The ehci-platform & ohci-platform have been used as a basis for this in case we
> wish to merge the drivers again in the future.
> 
> Changes since v2:
>  - Based on Arnd Berghman feedback, split out into 2 devices / drivers
>  - Base drivers oh ehci-platform.c & ohci-platform.c with required extensions
>    to allow possible re-merge in the furture.

Hi Peter,

This looks much better than the first version. I have some remaining comments for
how it could be simplified a bit more.

The way that you deal with the 48mhz clock seems like it should fit in well
with the generic driver, just like all the rest (once the usb-st-common
stuff is moved into the ohci/ehci drivers), so the alternative would be
to make it all generic now.

	Arnd
