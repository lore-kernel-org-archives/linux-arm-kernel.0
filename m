From: anders.berg@avagotech.com (Anders Berg)
Date: Mon, 22 Sep 2014 12:47:59 +0200
Subject: [PATCH] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <20140922095939.GB1406@katana>
References: <1408967482-17723-1-git-send-email-anders.berg@avagotech.com>
 <20140920121242.GA3833@katana>
 <CAE0=X_0VQ8rWrUgbsgKm1MwCP8bwWm3UJPq9p=xNDfjP4CC7Bg@mail.gmail.com>
 <20140922095939.GB1406@katana>
Message-ID: <CAE0=X_1v_1eNr=dPTgofamFuy6zP9ff=LS7dyexj4CeutDqaPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 11:59 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> >> +static int
>> >> +axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
>> >> +{
>> >> +     u32 int_mask = MST_STATUS_ERR | MST_STATUS_SNS;
>> >> +     u32 rx_xfer, tx_xfer;
>> >> +     u32 addr_1, addr_2;
>> >> +     int ret;
>> >> +
>> >> +     if (msg->len == 0 || msg->len > 255)
>> >> +             return -EINVAL;
>> >
>> > Ouch, really? Maybe we should warn the user here.
>>
>> Yeah, the transfer length register limits the length to 255. I'll add
>> a warning here.
>
> Please also add this information to the Kconfig description and
> somewhere at the top of the source file. This is an important flaw which
> people should easily find out about.
>

You are referring to the "len <= 255" restriction being the flaw here,
right? I'll add a note to Kconfig and the driver about that.

The other part of the condition (msg->len == 0) should actually go
away. The controller can do zero-length-data transfers. I'll fix that
for next round.

/Anders
