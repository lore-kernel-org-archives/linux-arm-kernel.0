From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Tue, 2 Dec 2014 19:00:40 +0530
Subject: [PATCH 3/4] devicetree: bindings: Add defeature-repeated-start
 property for Cadence I2C
In-Reply-To: <20141202131611.GC4072@katana>
References: <1417514749-24319-1-git-send-email-harinik@xilinx.com>
 <1417514749-24319-4-git-send-email-harinik@xilinx.com>
 <20141202111907.GC23671@leverpostej>
 <CAFcVECLtPx6shBXJbg9Uf_8fnhkMoO1zpoxGcdda7PSA7z_2rA@mail.gmail.com>
 <20141202125203.GA4072@katana>
 <CAFcVECJwFoFd6GrmF282CG+fELnYb=FNCTDq=RYKky_dHha=Jg@mail.gmail.com>
 <20141202131611.GC4072@katana>
Message-ID: <CAFcVECKMqACtumHZGHbToUUSjd_dWCcLbu=_ZjNnnGdAZQ_3fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 2, 2014 at 6:46 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> But given the bugs, it will be useful to just disable it if the system doesn't
>> require repeated start.
>
> What do you do when disable repeated start? Sending STOP and START? If
> so, this is really something different than repeated start. By using
> I2C_FUNC_I2C a user expects repeated start, so if the HW does not
> support it, we should say so and don't try to emulate it with something
> different.
>

Yes, we send stop.
Using repeated start, when number of messages passed > 1, HOLD bit is set
by the driver. This is an indication to the controller not to send a STOP.
If we disable repeated start, the driver will not set HOLD bit.
All the messages are sent but with START and a STOP for each of them.

Regards,
Harini
