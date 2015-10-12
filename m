From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Oct 2015 17:42:10 +0800
Subject: [PATCH v2 5/5] ARM: dts: sun6i: Add support for Sinlinx A31s SDK
 board
In-Reply-To: <20151012093034.GZ2278@lukather>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
 <1444488540-11263-6-git-send-email-wens@csie.org>
 <20151012093034.GZ2278@lukather>
Message-ID: <CAGb2v65zYqYWJ5C6yFgjyYV3RPMHcXZp3+PfbB_GXByb6Mt-Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 5:30 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sat, Oct 10, 2015 at 10:49:00PM +0800, Chen-Yu Tsai wrote:
>> +&i2c0 {
>> +     /* Available on camera header */
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&i2c0_pins_a>;
>> +     status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +     /* Available on LCD header */
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&i2c1_pins_a>;
>> +     status = "okay";
>> +};
>
> Are those two actually used anywhere on the board itself, or just
> exposed on the pin headers?

They are exposed as grouped headers. 1 header has all the camera
related stuff, like the CSI pins, and various voltage sources
from the PMIC. The other has the LCD pins, resistive touchpanel,
I2C for capacitive touchpanel, and of course voltage sources.

The LCD header is an FPC connector, while the camera header is
the common (common for sunxi devboards) 2.0mm pins. I'm not sure
if there is some common pinout amongst vendors, but at least
Sinlinx sells their own 7" LCD display w/ CTP, VGA converter,
and camera modules. I have both the LCD and VGA converter.

Note that these I2C pins have valid external pull-ups. I doubt
they can be easily re-purposed.

Regards
ChenYu
