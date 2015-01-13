From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 10:02:59 +0100
Subject: [PATCH] ARM: dts: hip04: move bootwrapper to SRAM
In-Reply-To: <54B4DA7E.2020602@hisilicon.com>
References: <54B48D5E.6050902@hisilicon.com> <9190510.INCMcmsads@wuerfel>
 <54B4DA7E.2020602@hisilicon.com>
Message-ID: <3703587.1qvjMFgdrL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 January 2015 16:42:38 Wei Xu wrote:
> On 2015/1/13 16:33, Arnd Bergmann wrote:
> > On Tuesday 13 January 2015 11:13:34 Wei Xu wrote:
> >> There is 8MB SRAM in hip04.
> >> Moving the bootwrapper into SRAM could avoid to worry about poking
> >> holes into DRAM memory or allocation algorithms either.
> >>
> >> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> >> ---
> >>  arch/arm/boot/dts/hip04.dtsi | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> >> index 2388145..f0dfac7 100644
> >> --- a/arch/arm/boot/dts/hip04.dtsi
> >> +++ b/arch/arm/boot/dts/hip04.dtsi
> >> @@ -22,7 +22,7 @@
> >>  
> >>         bootwrapper {
> >>         compatible = "hisilicon,hip04-bootwrapper";
> >> -       boot-method = <0x10c00000 0x10000>, <0xe0000100 0x1000>;
> >> +       boot-method = <0xe00f0000 0x10000>, <0xe0000100 0x1000>;
> >>         };
> 
> Hi Arnd,
>  
> > Is this backwards compatible with old firmware?
> 
> Sorry, it is not backwards compatible.
> Another reason is that it could support opensuse 
> more smoothly.
> 
> I have updated the firmware and uploaded it 
> into Linaro Hisilicon git tree last month.
> We will update the wiki on Linaro soon.
> 
> Do you think it is OK?

Generally speaking it's not ok to change firmware interfaces in
an incompatible way. The preferred way to handle this would be
to have the firmware that puts the boot wrapper into a different
place also update this property, if at all possible.

This unfortunately means that you will have to yet again publish
a firmware update image.

	Arnd
