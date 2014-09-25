From: dianders@chromium.org (Doug Anderson)
Date: Wed, 24 Sep 2014 21:36:38 -0700
Subject: [PATCH] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
In-Reply-To: <5423765B.8000706@rock-chips.com>
References: <1411523743-3444-1-git-send-email-addy.ke@rock-chips.com>
 <CAD=FV=WiHR+KcTWHnma6TdPQcc3oc4wqAofj5kF=Sgec_5kGAQ@mail.gmail.com>
 <54227F93.7000507@rock-chips.com>
 <CAD=FV=Uq9AteUcpMvcU5tmyGZbVYWM6PNmevZXSVCkYB8rqSsQ@mail.gmail.com>
 <5423765B.8000706@rock-chips.com>
Message-ID: <CAD=FV=Uuk1zBYn4NgcpDSHVfKeyw3MONO7roUNVSPSDDEyD=8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Wed, Sep 24, 2014 at 6:56 PM, addy ke <addy.ke@rock-chips.com> wrote:
> In my measurement,all paramter but "Data hold time" are match the characteristics of SCL bus line.
> the measured value is 0.928us("data hold time on RK3X"  ~=  "the low period / 2")
> but the maximum value described in table is 0.9us
>
> About "Data hold time", there are described in I2C specification:
> - for CBUS compatible masters for I2C-bus deivices
> - the maximum data hold time has only be met if the device does not stretch the LOW period of the SCL signal.
>
> I have tested on RK3288-Pinky board, there are no error.
> But I don't known whether this paramter will affect i2c communications.

I'll have to spend more time tomorrow to really understand this, but
if changing the code to bias towards slightly longer "high" times
instead of "low" times helps fix it then that's fine with me.
