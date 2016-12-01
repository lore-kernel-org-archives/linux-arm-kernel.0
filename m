From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 1 Dec 2016 18:23:20 +0100
Subject: [PATCH] ARM: BCM5301X: Enable UART by default for BCM4708(1) and
 BCM4709(4)
In-Reply-To: <CAC3K-4o3-eSDU5JvjkgohtWLUmZqQViHvX1h2zfdPAGe+qbCOg@mail.gmail.com>
References: <20161128140134.25128-1-zajec5@gmail.com>
 <CAC3K-4o3-eSDU5JvjkgohtWLUmZqQViHvX1h2zfdPAGe+qbCOg@mail.gmail.com>
Message-ID: <CACna6rygrQuZqaViTVQM5P8ieA2Gh-h-zrEZETAQrHHT9cnrWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2016 at 18:14, Jon Mason <jon.mason@broadcom.com> wrote:
> On Mon, Nov 28, 2016 at 9:01 AM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>>
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> Every device tested so far got UART0 (at 0x18000300) working as serial
>> console. It's most likely part of reference design and all vendors use
>> it that way.
>>
>> It seems to be easier to enable it by default and just disable it if we
>> ever see a device with different hardware design.
>>
>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>> ---
>>  arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 4 ----
>>  arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       | 4 ----
>>  arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       | 4 ----
>>  arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 4 ----
>>  arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 4 ----
>>  arch/arm/boot/dts/bcm4708.dtsi                     | 4 ++++
>>  arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 4 ----
>>  arch/arm/boot/dts/bcm47081.dtsi                    | 4 ++++
>>  arch/arm/boot/dts/bcm4709-netgear-r7000.dts        | 4 ----
>>  arch/arm/boot/dts/bcm4709-netgear-r8000.dts        | 4 ----
>>  arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  | 4 ----
>>  arch/arm/boot/dts/bcm4709.dtsi                     | 1 +
>>  arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      | 4 ----
>>  arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      | 4 ----
>>  arch/arm/boot/dts/bcm47094-netgear-r8500.dts       | 4 ----
>>  arch/arm/boot/dts/bcm47094.dtsi                    | 1 +
>
>
> I think there are a few missing here.  A quick grep shows
>
> $ grep -rI '#include "bcm470[89].dtsi"'  arch/arm/boot/dts/*.dts
> arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm4708-netgear-r6250.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts:#include "bcm4709.dtsi"
> arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts:#include "bcm4709.dtsi"
> arch/arm/boot/dts/bcm4709-netgear-r7000.dts:#include "bcm4709.dtsi"
> arch/arm/boot/dts/bcm4709-netgear-r8000.dts:#include "bcm4709.dtsi"
> arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts:#include "bcm4709.dtsi"
> arch/arm/boot/dts/bcm94708.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm94709.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm953012er.dts:#include "bcm4708.dtsi"
> arch/arm/boot/dts/bcm953012k.dts:#include "bcm4708.dtsi"
>
> I specifically care about the last 4 :)

Actually the only missing ones are the last 4. Other ones (e.g.
bcm4709-buffalo-wxr-1900dhp.dts) never got uart0 enabled so I just
didn't need to modify these files.

I'll send V2 updating last 4 ones as well. Thanks for catching this.
