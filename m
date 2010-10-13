From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 13 Oct 2010 10:15:04 +0200
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <87aamjxe00.fsf@lechat.rtp-net.org>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	<87aamjxe00.fsf@lechat.rtp-net.org>
Message-ID: <4CB56A88.2040101@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 13/10/2010 00:06, Arnaud Patard (Rtp) a ?crit :
> Wolfram Sang<w.sang@pengutronix.de>  writes:
>> Here is the hopefully final (famous last words) version of my patch series. The
>> first four are still updates/improvements for sdhci and sdhci-pltfm and are of
>> generic interest, too. Thanks to Eric for the tests on MX25/35. Looking forward
>> to comments/applied-to-mmc-next-messages ;)
>>
>> The series is based on mmc-next as of today and also available at
>>
>> 	git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc
>
> I've tried it on a efika mx (to2 version) and I've a problem with the
> write-protect. It's on a GPIO and I don't see any way to configure the
> esdhc-imx driver to use it. Any idea on how it should be done ?
>
it's actually not yet supported by the driver. There is a wp_gpio in
struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
but it's not yet used by the driver.
Also card detect using a GPIO is not implemented and card detect if 
actually done by polling.

Eric
