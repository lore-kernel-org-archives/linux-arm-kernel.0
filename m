From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  7 Nov 2011 17:08:30 +0100
Subject: [PATCHv3] AT91: Add a driver for the ADC
In-Reply-To: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1320682113-23655-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patchset adds the driver for the ADC in the AT91 SoC. It has been tested on
the at91sam9g20ek and should work on sam9g45 as well.

For now, it only reads values when asked for by sysfs, but eventually will
support hardware triggers and more boards.

This patchset is based on the "[PATCH 0/6 V2] IIO: Out of staging step 1: The
core" patchset from Jonathan Cameron, applied on top of 3.1

Improvements since v2:
  - Move the driver out of staging
  - Slightly modify the definition of channels to use bitmaps
  - The driver no longer leaks the channels array
  - Various minor fixes and codestyle improvements

Improvements since v1:
  - Rebase on top of commit 85d8ff8
  - Initialise scan_types
  - Added scale informations in the driver
  - Allow to use only a subset of adc channels available on the SoC
  - Various fix according to reviews

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
