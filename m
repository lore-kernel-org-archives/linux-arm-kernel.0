From: marex@denx.de (Marek Vasut)
Date: Sat, 9 Jun 2012 15:10:31 +0200
Subject: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <CAM=Q2cvvwXimLY358ET69U6qCsGoxenYMNtApYbhpn4cCC0nUg@mail.gmail.com>
References: <1339181689-22573-1-git-send-email-marex@denx.de>
 <201206091234.47309.marex@denx.de>
 <CAM=Q2cvvwXimLY358ET69U6qCsGoxenYMNtApYbhpn4cCC0nUg@mail.gmail.com>
Message-ID: <201206091510.31232.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shubhrajyoti Datta,

> >> > +struct mxs_i2c_speed_config {
> >> > +       uint32_t        timing0;
> >> > +       uint32_t        timing1;
> >> > +       uint32_t        timing2;
> >> > +};
> >> > +
> >> > +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
> >> 
> >> You are using 95k?
> > 
> > Yes
> > 
> >> Didnt understand this.
> > 
> > What exactly, it's running (according to the datasheet) at 95kHz.
> 
> Did you intend 100k?

I intended to stick with the datasheet, if you manage to find explanation for 
why they chose 95kHz, I'd be interested to hear it ... btw. 24MHz/95kHz gives 
pretty weird divider, which is quite suspicious.

> and approximating due to clock ... or some other limitaion?

Doesn't seem to be the case, see "btw" part above.

> That is what I was trying to understand.
> 
> >> > +       .timing0        = 0x00780030,
> >> > +       .timing1        = 0x00800030,
> >> > +       .timing2        = 0x0015000d,
> >> > +};

Best regards,
Marek Vasut
