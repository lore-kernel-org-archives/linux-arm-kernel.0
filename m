From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  3 Nov 2011 11:11:07 +0100
Subject: [PATCHv2] AT91: Add a driver for the ADC
In-Reply-To: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patchset adds the driver for the ADC in the AT91 SoC. It has been tested on
the at91sam9g20ek and should work on sam9g45 as well.

For now, it only reads values when asked for by sysfs, but eventually will
support hardware triggers and more boards.

This patchset is based on the branch master of Jonathan Cameron present at :
https://github.com/jic23/linux-iio/, commit 85d8ff8

Improvements since v1:
  - Rebase on top of commit 85d8ff8
  - Initialise scan_types
  - Added scale informations in the driver
  - Allow to use only a subset of adc channels available on the SoC
  - Various fix according to reviews

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
