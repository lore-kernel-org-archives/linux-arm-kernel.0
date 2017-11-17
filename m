From: phil@raspberrypi.org (Phil Elwell)
Date: Fri, 17 Nov 2017 19:51:57 +0000
Subject: [PATCH] ARM: dts: bcm2835-rpi: Avoid conflicts on i2c0
In-Reply-To: <CAAoAYcPz6urucU1r_uNk1kvjsGg0p7VUrZwa5GZSDeDgsD=5Fw@mail.gmail.com>
References: <1510779424-642-1-git-send-email-stefan.wahren@i2se.com>
 <87a7zmq7wy.fsf@anholt.net>
 <CAAoAYcPz6urucU1r_uNk1kvjsGg0p7VUrZwa5GZSDeDgsD=5Fw@mail.gmail.com>
Message-ID: <cdafd9a1-e965-ac9a-8640-de21c3eca5e5@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/2017 18:30, Dave Stevenson wrote:
> On 16 November 2017 at 20:34, Eric Anholt <eric@anholt.net> wrote:
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>>> The GPU firmware of the Raspberry Pi 3 uses i2c0 to communicate to
>>> the FXL6408 gpio expander. It's a bad idea to use the same interface
>>> from the ARM side. Since this interface isn't used by the other
>>> RPi boards, it's save to remove the complete node and avoid this
>>> conflict.
>>
>> It's not used by other kernel drivers currently, but should we leave it
>> in for the pi0/1/2 folks that might have userspace I2C stuff using it?
>> That's a thing people do, right?  I actually don't know.
>
> The firmware hasn't used BSC0 for the GPIO expander since the end of
> January. It now bit bashes it. Sorry if that information hadn't
> filtered through.
>
> I've got a patch I was about to send to rpi-linux for comment which
> sets up the i2c-mux-pinctrl driver on BSC0 so that it can be used
> either on GPIOs 0&1, or the GPIOs connected to the DSI and CSI
> connectors (I want it to talk to the camera module, and I guess Eric
> won't complain for talking to the DSI display). I'll aim to sort it on
> Monday.

Regardless of the use (or not) of i2c0 by the VPU on Pi 3, i2c0 is the I2C interface
intended for the ARM on early Pi Model Bs. The enabling or not of the I2C
interfaces should be left to the model-specific DTS files.

Regards,

Phil
