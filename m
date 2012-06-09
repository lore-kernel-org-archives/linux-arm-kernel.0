From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Sat, 9 Jun 2012 18:16:50 +0530
Subject: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <201206091234.47309.marex@denx.de>
References: <1339181689-22573-1-git-send-email-marex@denx.de>
 <CAM=Q2cuv0NQTYJH=+d6Na+JK5rGYsLiSmuX7g8T-_Ry7bs3fRQ@mail.gmail.com>
 <201206091234.47309.marex@denx.de>
Message-ID: <CAM=Q2cvvwXimLY358ET69U6qCsGoxenYMNtApYbhpn4cCC0nUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >
>> > +struct mxs_i2c_speed_config {
>> > + ? ? ? uint32_t ? ? ? ?timing0;
>> > + ? ? ? uint32_t ? ? ? ?timing1;
>> > + ? ? ? uint32_t ? ? ? ?timing2;
>> > +};
>> > +
>> > +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
>>
>> You are using 95k?
>
> Yes
>
>> Didnt understand this.
>
> What exactly, it's running (according to the datasheet) at 95kHz.

Did you intend 100k?
and approximating due to clock ... or some other limitaion?

That is what I was trying to understand.
>
>> > + ? ? ? .timing0 ? ? ? ?= 0x00780030,
>> > + ? ? ? .timing1 ? ? ? ?= 0x00800030,
>> > + ? ? ? .timing2 ? ? ? ?= 0x0015000d,
>> > +};
