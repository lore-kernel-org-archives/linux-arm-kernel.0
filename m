From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 30 Jan 2017 09:22:23 +0100
Subject: [PATCH 2/4] mmc: bcm2835: Add new driver for the internal SD
 controller.
In-Reply-To: <ec09cd58-6613-82d7-60a9-7a7c2d9ae673@i2se.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-3-git-send-email-kraxel@redhat.com>
 <CAPDyKFoWyZaRLhuBnFfJupxRnUvq-JWczS7ObjAGat056MCEyw@mail.gmail.com>
 <ec09cd58-6613-82d7-60a9-7a7c2d9ae673@i2se.com>
Message-ID: <CAPDyKFr=x9KkzWxaeTJsJgonGMPY_RV6i2HRLLsqB9zZgYiy5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2017 at 17:04, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Am 27.01.2017 um 16:27 schrieb Ulf Hansson:
>> On 27 January 2017 at 12:36, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> From: Eric Anholt <eric@anholt.net>
>>>
>>> The 2835 has two SD controllers:  The Arasan SDHCI controller (supported
>>> by the iproc driver) and a custom SD controller.  This patch adds a
>>> driver for the custom SD controller.
>>>
>>> The custom controller runs faster, and driving the sdcard with the
>>> custom controller also allows to drive the rpi3 wifi with the iproc
>>> driver.
>>>
>> I don't understand this relationship. Is this somewhat configurable in runtime?
>
> The configuration is done by devicetree via pin muxing. AFAIK both SD
> controller are available on the same pins (2 pin groups = pin 22 to 27 +
> pin 48 to 53). So it's possible to use both SD controllers at the same
> time with different pin groups. This is necessary to use Wifi via SDIO
> on the RPi 3 while the other controller handles SD card with the rootfs.
>
>>
>> Is the WIFI module a removable SDIO card?
>
> No
>
>>  So you can decide which
>> controller that is best suited to use?
>
> Yes, but it requires also both drivers.
>

Okay, thanks for clarifying - I will go on with the review.

If a re-spin of the series is needed, please make sure to update the
coverletter with some information from above, so I don't get confused
again. :-)

Kind regards
Uffe
