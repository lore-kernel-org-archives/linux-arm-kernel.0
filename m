From: dianders@chromium.org (Doug Anderson)
Date: Thu, 3 Sep 2015 09:28:09 -0700
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <1441296838.3102.12.camel@pengutronix.de>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
 <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
 <20150903082210.GU21084@n2100.arm.linux.org.uk>
 <CAL_JsqL838-somj-o2QtxRA9bXon5dHijx22v0mVowqyhKgoUQ@mail.gmail.com>
 <20150903151854.GA21084@n2100.arm.linux.org.uk>
 <CAL_JsqLKbW2ur1US1DCAcJeDYzq8f1L3vO9C8TitAqGt9tAusQ@mail.gmail.com>
 <CAD=FV=XdP9T29drocB_WkNKrDif9Qwrdjt2C4=AwQk9rey3yLg@mail.gmail.com>
 <1441296838.3102.12.camel@pengutronix.de>
Message-ID: <CAD=FV=XB9S7-PtshFjBgUwv3oGoXamsGBnwBBrw00aoBpr6q7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lucas,

On Thu, Sep 3, 2015 at 9:13 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>> 6. Once you start using the dw_hdmi's i2c block with the currently
>> posted patch against mainline (to do this you not only need the patch
>> but you need to remove the ddc-i2c-bus property, set the pinmux, and
>> disable i2c5) then you'll see a bonafide i2c bus exposed to Linux.  In
>> my case this stole i2c0 away from the builtin SoC I2C bus and caused
>> the SoC I2C bus to fail to probe.  Doh.
>>
> This shouldn't happen. I don't know if the patches landed yet, but I
> know Wolfram (i2c maintainer) had patches to reserve the range of bus
> numbers that are fixed by alias nodes and don't hand out those numbers
> to adapters with a dynamic bus number allocation.
>
>> 7. I was trying to solve #6 by adding an "of_node" to the i2c bus
>> which allowed me to give it a (non-conflicting) bus ID.
>>
> This should not be needed.

Ah.  It's very possible that the issue is due to the fact that I was
testing this on an old kernel (3.14) that's missing that feature.  OK,
if that's fixed then at least the actual bug (making i2c0 fail to
load) is not a problem.  It'd still be nice to be able to assign a bus
number to this bus just to make reading of the logs easier, but it's
not a functionality requirement.

-Doug
