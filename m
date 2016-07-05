From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 5 Jul 2016 16:46:02 +0200
Subject: [PATCH 2/3] ARM: dts: imx6sx: Add UDOO Neo support
In-Reply-To: <20160705062736.GL16643@pengutronix.de>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
 <1467691450-22975-3-git-send-email-afaerber@suse.de>
 <20160705062736.GL16643@pengutronix.de>
Message-ID: <577BC82A.3000406@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Am 05.07.2016 um 08:27 schrieb Uwe Kleine-K?nig:
> On Tue, Jul 05, 2016 at 06:04:09AM +0200, Andreas F?rber wrote:
>> +&iomuxc {
>> +	imx6sx-udoo-neo {
> 
> There is no need for this machine group. Please just put the pinctrl
> groups directly into &iomuxc { }.

OK, will do. Adopted from imx6sx-sdb.dtsi and imx6sx-sabreauto.dts -
please update the existing files to be like you expect new ones to be.

>> +		pinctrl_enet1: enet1grp {
>> +			fsl,pins =
>> +				<MX6SX_PAD_ENET1_CRS__GPIO2_IO_1	0xa0b1>,
>> +				<MX6SX_PAD_ENET1_MDC__ENET1_MDC		0xa0b1>,
> 
> It's unusual to write pinmuxes this way. The usual form is to write it
> in a single array. (Not sure I'm using the right term here.) Having said
> that I like it your way, but still it should (IMHO) get a more official
> blessing.

In previous reviews I've been told that this is the new expected way to
write tuples, so I assumed that would apply here too, in that you can
have a varying count of tuples (mux lines), which in this case happen to
always have the same cell count (6).

For example I've rewritten pinctrl-0 lines in exynos5250 device trees
because maintainers considered it lazy to spare the inner ">, <",
despite still used in many places including bindings documentation.

The binary .dtb representation should be the same either way.

booting-without-of.txt doesn't comment and has no such example apart
from compatible string lists, so not sure whether that's just different
maintainer tastes or formalized somewhere?

That said, I seem to have a talent for finding such inconsistencies. ;)

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
