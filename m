From: george.joseph@fairview5.com (George Joseph)
Date: Mon, 16 Mar 2015 15:33:49 -0600
Subject: [PATCH] dts: cubox: Map gpio-keys and pps-gpio to gpio3 8
In-Reply-To: <20150316205004.GO8656@n2100.arm.linux.org.uk>
References: <1426538201-7571-1-git-send-email-george.joseph@fairview5.com>
 <20150316205004.GO8656@n2100.arm.linux.org.uk>
Message-ID: <CAHKv19CYD59Ssf6LMyh8K12_5tGLq+yX=sNXWyvU0fPo3JN57g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 2:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 16, 2015 at 02:36:41PM -0600, George Joseph wrote:
>> The Cubox has a recessed button between the HDMI and RJ-45 connectors
>> that wasn't mapped in the device tree.  Since the button is normally
>> open and there's no external pull up/down, that pad (EIM_DA8) can be
>> used for almost anything so I've mapped it to gpio-keys BTN_0 and
>> pps-gpio.  Whichever driver claims it first wins.  If both drivers
>> are build as modules, you can even switch between them at run time
>> and the pinmux will adjust the pin configuration as required.
>> If neither driver claims the gpio, it's still available in the normal
>> gpio sysfs.
>
> I wonder why we want to have the PPS support in mainline, given that
> you would need to solder to the board to make use of that.  I can see
> the point of the gpio-keys going into mainline, but not the PPS bit.
> That's more like a local hack.
>

Well, it was just one less thing I'd have to patch locally for so I
took a chance. :)    I'll remove the pps bits and resubmit.
