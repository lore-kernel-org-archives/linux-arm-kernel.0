From: raltherr@google.com (Rick Altherr)
Date: Sun, 27 Aug 2017 19:55:43 -0700
Subject: [patch v6 0/3] JTAG driver introduction
In-Reply-To: <CACRpkdb75L5BrYN+V-BMwzrRm8_Wtymr3d08eMWt43FiBpH5Qg@mail.gmail.com>
References: <1503418256-5215-1-git-send-email-oleksandrs@mellanox.com>
 <CACRpkdZePXyo8Q36mBH7OnJU3E=yWPWSGkGUOH=zJFMjM=Yrhw@mail.gmail.com>
 <CAPLgG==Jj=Ys=SvhOCspSfunbWnuqPySvW9RfuqE8HYnG4C=ZQ@mail.gmail.com>
 <CACRpkdbozWaL0RXyZXjzxYK3JHiqYziSkTGSgGORdptX-rwR8A@mail.gmail.com>
 <CAPLgG=mv1p98e4Vzso1N-VU=1MSotkTmnF+DcDTXPcd3q-n8HA@mail.gmail.com>
 <CACRpkdb75L5BrYN+V-BMwzrRm8_Wtymr3d08eMWt43FiBpH5Qg@mail.gmail.com>
Message-ID: <CAPLgG=n2r+rJKSAZKknuqH_S2W6CrWN-Ynqph-qPc9BTs-_hQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 27, 2017 at 3:30 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Aug 25, 2017 at 6:52 PM, Rick Altherr <raltherr@google.com> wrote:
>
>>> Incidentally, people are sending patches to expose the FTDI
>>> expanders as common GPIO chips under Linux, so we can
>>> internally in the kernel or from the usersapce character device
>>> access them as "some GPIOs".
>>
>> I know my team at Google has an internal patch for exactly that.  FTDI
>> expanders are complicated as they can be used as UART, GPIO, I2C, SPI
>> depending on configuration.  Our project was using a mix of I2C and
>> GPIO so I directly my team to approach it as an MFD.  I'd like to see
>> all of these use cases handled by the kernel but I understand the
>> other viewpoint of relying on libusb for cross-platform compatiblity.
>
> Hm. I see. But I see people pushing the in-kernel method so I think
> it will eventually win out.
>

SGTM.  I'll see if my team can clean up the MFD-based FTDI driver and
submit it upstream.

>>>>> In my worst nightmare they export GPIO lines using
>>>>> the horrid ABI in /sys/gpio/*
>>>>
>>>> https://sourceforge.net/p/openocd/code/ci/v0.10.0/tree/src/jtag/drivers/sysfsgpio.c
>>>
>>> Gnah!
>>> Whoever writes a slot-in replacement making the character device
>>> take precendence wins lots of karma.
>>
>> If they show up at Linux Plumbers or visit San Jose, I'll take them to
>> dinner.  I didn't see any docs for the chardev in Documentation.  I
>> _think_ I understand how it works from reading the relevant sections
>> of gpiolib.c but I can see how users end up using sysfs instead.
>
> I intended tools/gpio/* to be the documentation:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/gpio
>
> If we need more written documentation we can do it I guess,

I haven't been in the habit of looking in tools/.  Guess I should be.

>
> Yours,
> Linus Walleij
