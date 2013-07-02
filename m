From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Jul 2013 10:57:04 -0300
Subject: [PATCHv2 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
In-Reply-To: <1235070882.565234.1372771759233.open-xchange@email.1und1.de>
References: <1371754675-12242-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1371754675-12242-3-git-send-email-alexandre.belloni@free-electrons.com>
 <1235070882.565234.1372771759233.open-xchange@email.1und1.de>
Message-ID: <CAOMZO5AASS4sr08i4K-uSUuvG+x9cjfFUtheY9JatA4dWCB0ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Tue, Jul 2, 2013 at 10:29 AM, Christoph G. Baumann <cb@sgoc.de> wrote:
> Hello Alexandre,
>
>> The ADCs connected to this bus have been experiencing some timeout
>> issues when using the iMX28 i2c controller. Switching back to bitbanging
>> solves this.
>
> the chip errata for i.MX23(!) contains an issue (no 2727) with the I2C
> controller that is also applicable for the i.MX28:
>
> "
> 2727 I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK set.
>
> Description:
> When RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not generated. However,
> the SDA
> line is read at the proper timing interval. If RETAIN_CLOCK is cleared, the
> ninth clock pulse is
> generated.
> Also, the HW_I2C_VERSION register incorrectly states the version is 1.2. It
> should be 1.3.
>
> Workaround:
> HW_I2C_CTRL1[ACK_MODE] has default value of 0. It should be set to 1 to enable
> the fix for
> this issue.

Differently than mx23, the mx28 reference manual states that ACK_MODE
bit has a default value of 1.

Thanks for pointing this out, as we need to take this into
consideration for supporting mx23 in the mxs i2c driver.

Regards,

Fabio Estevam
