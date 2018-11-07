From: ndesaulniers@google.com (Nick Desaulniers)
Date: Wed, 7 Nov 2018 09:48:54 -0800
Subject: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
In-Reply-To: <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
 <20181107085503.GA31517@flashbox>
 <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
Message-ID: <CAKwvOdmkC1LqMokhQUebpEZRoWWWwtQnbm8xGwiwdBy9UOMT5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 07. 11. 18 9:55, Nathan Chancellor wrote:
> > On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
> >> On 01. 11. 18 1:57, Nathan Chancellor wrote:
> >>> Clang warns when one enumerated type is implicitly converted to another:
> >>>
> >>> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> >>> enumeration type 'enum zynq_pin_config_param' to different enumeration
> >>> type 'enum pin_config_param' [-Wenum-conversion]
> >>>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> >>>         ~               ^~~~~~~~~~~~~~~~~~~~~
> >>> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> >>> enumeration type 'enum zynq_pin_config_param' to different enumeration
> >>> type 'enum pin_config_param' [-Wenum-conversion]
> >>>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
> >>>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> >>> macro 'PCONFDUMP'
> >>>         .param = a, .display = b, .format = c, .has_arg = d     \
> >>>                  ^
> >>> 2 warnings generated.
> >>
> >> This is interesting. I have never tried to use llvm for building the
> >> kernel. Do you have any description how this can be done?
> >>
> >
> > Depending on what version of Clang you have access to, it is usually just as
> > simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.
> >
> > Clang 7.0+ is recommended but 6.0 might work too.
>
> TBH I would expect to download container and run this there to make sure
> that I don't break anything else.

This is the first request we've had for a container in order to test a
patch.  If it comes up again from other folks, I think it makes sense
to create one.  Until then, its nice to have.  It's definitely
overkill for this patch.

-- 
Thanks,
~Nick Desaulniers
