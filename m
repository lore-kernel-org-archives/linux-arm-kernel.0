From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 3 Nov 2011 12:27:28 +0100
Subject: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
In-Reply-To: <1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAKnu2MqTVPxioKyr-F6JWcdF5SRZjzLSFPt5A-6CkZO7HyeHRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/3 Maxime Ripard <maxime.ripard@free-electrons.com>:

> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> ?arch/arm/mach-at91/include/mach/board.h | ? 22 ++++++++++++++++++++++
> ?1 files changed, 22 insertions(+), 0 deletions(-)

We're not supposed to have platform data dependent to stuff in
staging under arch/arm or anyplace else in the main kernel tree.

Please move this to
drivers/staging/iio/adc/at91adc-board.h
or so.

As for calling the at91_add_device_adc() function (which I guess
you want to do at some point) the pattern I followed for other
drivers is to declare a dummy function in arch/arm/mach-*
with __weak and let the staging driver override that. This way
the staging driver can go away without any compilation trouble
happening.

Yours,
Linus Walleij
