From: aford173@gmail.com (Adam Ford)
Date: Mon, 7 Nov 2016 09:03:31 -0600
Subject: [PATCH] ARM: dts: imx6: Add support for Logic PD SOM and Baseboard
In-Reply-To: <20161105070043.GA5597@dragon>
References: <1469030786-28424-1-git-send-email-aford173@gmail.com>
 <20160809082400.GR4678@tiger>
 <CAHCN7x+YopHVNxh4Vi5o1d=S3FFkoz45dNmgHMgs1sAQqaL77A@mail.gmail.com>
 <20161105070043.GA5597@dragon>
Message-ID: <CAHCN7xJ=KK-=5sVu0Or5bep-cdk3hq4+a3gFj-W0bCcVhQyWNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 5, 2016 at 2:00 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Fri, Nov 04, 2016 at 12:44:21PM -0500, Adam Ford wrote:
>> >> +&iomuxc {
>> >> +     imx6qdl-logicpd-baseboard {
>> >> +
>> >
>> > Drop this container node and put the following pinctrl nodes directly
>> > under &iomuxc.
>> >
>>
>> Like the regulators above, if I remove this connector, the system
>> won't boot.  I compared both the regulator and the iomuxc containers
>> in this device tree with other imx6q boards, and I seem to be
>> consistent with what other boards are doing.
>
> You might want to rebase the patch to latest mainline like v4.9-rc3 and
> test first.

I rebased on the 4.9-rc4, and the pinmux errors go away, but the
regulators appear to need their own container or I get the following
error:

Warning (reg_format): "reg" property in /regulator-otg-vbus has
invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Warning (reg_format): "reg" property in /regulator-h1-vbus has invalid
length (4 bytes) (#address-cells == 1, #size-cells == 1)
Warning (reg_format): "reg" property in /regulator-3v3 has invalid
length (4 bytes) (#address-cells == 1, #size-cells == 1)
Warning (reg_format): "reg" property in /regulator-pcie has invalid
length (4 bytes) (#address-cells == 1, #size-cells == 1)

Can I leave the the regulator container?  This seems consistent with
the other imx6 boards.

adam

>
> Shawn
