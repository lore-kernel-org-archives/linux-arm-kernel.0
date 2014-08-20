From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 20 Aug 2014 16:20:22 +0200
Subject: [PATCH] mmc: sunxi: Declare ERASE capability
In-Reply-To: <3728016.4j3Ljjy6eM@dizzy-6.o2s.ch>
References: <1408541960-14788-1-git-send-email-wens@csie.org>
 <3728016.4j3Ljjy6eM@dizzy-6.o2s.ch>
Message-ID: <CAPDyKFq1yzdu19ReECRZzVynHZByN4803WdZ=vjgCnC9F0+MiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 August 2014 16:10, David Lanzend?rfer <david.lanzendoerfer@o2s.ch> wrote:
> Hi
>> Declare ERASE capability so we can use filesystems with the discard
>> option and the fstrim tool.
> I totally agree with you that information about such capabilities should be
> exposed but maybe it would be wiser to use DT instead of hardcoding it?

Nope, this is pure software support. No HW config.

What we should do future wise, is to remove the MMC_CAP_ERASE
entirely. Due to current existing bugs, mainly in mmc core layer
regarding erase, we can't do it yet.

> I mean a WiFi device won't support erase functionality...

That's already covered by the mmc core layer. No worries.

Kind regards
Uffe
