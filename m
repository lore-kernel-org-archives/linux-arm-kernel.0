From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 3 Apr 2018 20:14:04 +0200
Subject: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
In-Reply-To: <20180403181216.f22vtkqrnxjgreuo@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180403150139.l7oec4doafmsidfp@ninjato>
 <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
 <20180403181216.f22vtkqrnxjgreuo@ninjato>
Message-ID: <CAKv+Gu8R19T+9O2tODQeS9vtKANmBXgGcavkRdVRU0NmVtHn2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2018 at 20:12, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Yeah, good point. So when exactly should this be called? Only on error
>> conditions that could be caused by a misbehaving slave?
>
> Chapter 3.1.16 of the I2C specification, only when a slave keeps SDA
> low. Usually you detect that before you start transmitting.
>
> Really, please remove it for now and add it later, properly tested!
>

OK, I will remove it for now.

> BTW what kind of tests did you do with this driver so far?
>

I have used it with a ATSHA204A crypto chip, using a userland driver
and i2c-dev, and with a NXP PCF8563 RTC using the kernel driver.
