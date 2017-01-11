From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jan 2017 14:19:55 +0100
Subject: [PATCH] ARM: defconfig: qcom: add APQ8060 DragonBoard devices
In-Reply-To: <20170110145348.GD5710@hector.attlocal.net>
References: <20170110095521.14146-1-linus.walleij@linaro.org>
 <20170110145348.GD5710@hector.attlocal.net>
Message-ID: <CACRpkdb+bH1bj14d-2rBMadJQLCdVgdeuc07ESkuQpWt9UQ6rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 3:53 PM, Andy Gross <andy.gross@linaro.org> wrote:
> On Tue, Jan 10, 2017 at 10:55:21AM +0100, Linus Walleij wrote:
>> This default-enables the devices found on the APQ8060 DragonBoard
>> in the qcom_defconfig:
>>
>> - EBI2 bus
>> - SMSC911x ethernet
>> - LEDs class and PM8058 LEDs driver, trigger and heartbeat
>>   trigger (so we get heartbeat on the board by default)
>> - IIO framework, including the HRTimer trigger, KXSD9
>>   accelerometer, MPU3050 gyroscope, AK8975 magnetometer and
>>   BMP085 pressure sensor
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> This brings up a point of discussion.  Do we even need the qcom_defconfig any
> more?  Is everyone comfortable with using the multi_v7_defconfig?
>
> Aside from size of the image, i can't think of any other reason to keep around
> the separate qcom file.

Actually a bit of Arnd/Olof question.

Bystander opinion below:

That is pretty much up to the maintainer (you) I guess.
Reasons would be:

- Lower footprint (because you may not need all stuff selected
  as 'y' compiled-in in multi_v7) on some platforms this is even
  necessary to get a bootable image or one that will load in
  reasonable time.

- Enable a few things by default (both compiled-in and modules)
  that multi_v7 would consider to be littering

- For "my" systems I usually like them because these defconfigs
  have vastly shorter compile time (because so much stuff that
  idon't concern me is left out).

On the other hand: some ARMv7 system maintainers have x86
ambitions: compile once, run everywhere, and certainly that is
the ambition with multi_v7, and if that overshadows all the above,
just kill off qcom_defconfig and be happy :)

Yours,
Linus Walleij
