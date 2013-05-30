From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 May 2013 22:10:11 -0600
Subject: [PATCH V2 1/2] ARM: bcm2835: add simple framebuffer to device tree
In-Reply-To: <1365043257-29296-1-git-send-email-swarren@wwwdotorg.org>
References: <1365043257-29296-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51A6D123.10001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 08:40 PM, Stephen Warren wrote:
> Place a template simple-framebuffer device into the RPi device tree. The
> bootloader is expected to fill in all the parameters at boot time.
> Hence, disable the device by default, so if the bootloader doesn't do
> this, the device isn't activated with invalid parameters.

In the end, I dropped this patch, and decided to just have U-Boot create
this DT node itself from scratch, just like Olof did for the Samsung ARM
Chromebook.

I have however applied patch 2/2, to enable the simplefb driver in
bcm2835_defconfig.
