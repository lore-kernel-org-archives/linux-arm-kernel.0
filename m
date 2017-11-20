From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Nov 2017 11:30:49 +0100
Subject: [PATCH] ARM: dts: r8a779x: Add '#reset-cells' in cpg-mssr
In-Reply-To: <20171120102611.hyrufkxou27gspah@verge.net.au>
References: <1510839357-11450-1-git-send-email-geert+renesas@glider.be>
 <20171120094957.2seep3qw4j274zrv@verge.net.au>
 <CAMuHMdXPrv4bwZbGxE=DJp2nufjF5Q6JwFAERDvBFi+UsAXVsA@mail.gmail.com>
 <20171120102611.hyrufkxou27gspah@verge.net.au>
Message-ID: <CAK8P3a345J8JfVu4g+refG+y8r8VmMsjKPkUnYen4kMhQYvtEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 11:26 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Nov 20, 2017 at 10:57:07AM +0100, Geert Uytterhoeven wrote:
>> Hi Simon,
>>
>> On Mon, Nov 20, 2017 at 10:49 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Thu, Nov 16, 2017 at 02:35:57PM +0100, Geert Uytterhoeven wrote:
>> >> From: Arnd Bergmann <arnd@arndb.de>
>> >>
>> >> With the latest dtc, we get many warnings about the missing
>> >> '#reset-cells' property in these controllers, e.g.:
>> >>
>> >> arch/arm/boot/dts/r8a7790-lager.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /can at e6e80000:resets[0])
>> >> arch/arm/boot/dts/r8a7792-blanche.dtb: Warning (resets_property): Missing property '#reset-cells' in node /soc/clock-controller at e6150000 or bad phandle (referred from /soc/dma-controller at e6700000:resets[0])
>> >> arch/arm/boot/dts/r8a7792-wheat.dtb: Warning (resets_property): Missing property '#reset-cells' in node /soc/clock-controller at e6150000 or bad phandle (referred from /soc/ethernet at e6800000:resets[0])
>> >> arch/arm/boot/dts/r8a7793-gose.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /gpio at e6050000:resets[0])
>> >> arch/arm/boot/dts/r8a7794-alt.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /i2c at e6500000:resets[0])
>> >> arch/arm/boot/dts/r8a7794-silk.dtb: Warning (resets_property): Missing property '#reset-cells' in node /clock-controller at e6150000 or bad phandle (referred from /interrupt-controller at e61c0000:resets[0])
>> >>
>> >> This adds it for the three r8a779x chips that were lacking it. The
>> >> binding mandates this as <1>, so this is the value I use.
>> >>
>> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> >> [geert: Add fix for r8a7793.dtsi]
>> >> Fixes: 34fbd2b12761d111 ("ARM: dts: r8a7790: Add reset control properties")
>> >> Fixes: 6e11a322f1d7505d ("ARM: dts: r8a7792: Add reset control properties")
>> >> Fixes: 84fb19e1d201ba86 ("ARM: dts: r8a7793: Add reset control properties")
>> >> Fixes: 615beb759ca494a4 ("ARM: dts: r8a7794: Add reset control properties")
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >
>> > Thanks for following up on this, its been fouling up my todo list for a
>> > while now. Applied for v4.16.
>>
>> As this is a fix for changes made in v4.15-rc1, don't we want it in v4.15?
>
> Do the changes have any run-time effect?
> If not I'd prefer not to push them into v4.15 as fixes.

The main effect right now is that we're up from no warnings in the
default build to
hundreds of warnings, which is really annoying. Obviously there is
little gain in
fixing these but not the other warnings that were introduced, but I would either
want to fix them all, or disable the warning for one more release.

Rob, what do you think we should do here?

       Arnd
