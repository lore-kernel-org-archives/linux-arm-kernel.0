From: robherring2@gmail.com (Rob Herring)
Date: Thu, 3 Sep 2015 10:46:20 -0500
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <20150903151854.GA21084@n2100.arm.linux.org.uk>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
 <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
 <20150903082210.GU21084@n2100.arm.linux.org.uk>
 <CAL_JsqL838-somj-o2QtxRA9bXon5dHijx22v0mVowqyhKgoUQ@mail.gmail.com>
 <20150903151854.GA21084@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqLKbW2ur1US1DCAcJeDYzq8f1L3vO9C8TitAqGt9tAusQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2015 at 10:18 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 03, 2015 at 09:46:38AM -0500, Rob Herring wrote:
>> Yes, that is fairly common (ADV75xx is same), and we would not
>> describe an I2C bus in DT in that case. Same with HPD directly handled
>> vs. a GPIO line. That is no different than what Doug has said:
>> ddc-i2c-bus is present if using the SOC's I2C host and absent if using
>> the HDMI block's DDC functionality. I'm only questioning the location
>> of the property.
>
> No, I don't think that's what Doug wants.  Doug wants the bridge's
> internal I2C host to be exposed, so he can number it through a DT
> alias.

See his earlier reply and other patch[1] which states once the dw_hdmi
built-in I2C controller support is added in mainline, then this
property is not needed. For now, the SOC's general purpose I2C
controller is used.

Rob

[1] https://lkml.org/lkml/2015/9/2/571
