From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 25 Sep 2014 09:18:00 +0200
Subject: [PATCH 2/2] ARM: dts: Add rtc_src clk for s3c-rtc on
 exynos5250-snow
In-Reply-To: <54235360.7090303@samsung.com>
References: <1410954633-27025-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410954633-27025-3-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=W7xJ01m2oLtuDnogOmrpwpztbir=59oSWU6oojFYUWKw@mail.gmail.com>
 <5419ADF9.3010509@suse.de> <00f801cfd6f6$07e10500$17a30f00$@kernel.org>
 <5421992F.6070908@samsung.com> <54219D47.6010102@collabora.co.uk>
 <54233A84.7040902@collabora.co.uk> <54235360.7090303@samsung.com>
Message-ID: <5423C1A8.6080603@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On 09/25/2014 01:27 AM, Kukjin Kim wrote:
>>
>> Today I also had time to review the rebased patches from Andreas and found
>> two issues introduced during the merge conflict resolution:
>>
> Oops. Thanks for your quick fix it up.
>

You are welcome.
 
>> 1) The spi_1 dev node on exynos5250-smdk5250.dts now uses the old "cs-gpio"
>>     DT property under the controller-data instead of the standard "cs-gpios"
>>     under the SPI parent. IOW, is a regression of the bug fixed in commit
>>     e138d43 ("ARM: dts: fix the chip select gpios definition in the SPI nodes").
>>
>> 2) The display-timings child node of the dp-controller was removed in commit
>>     a98c3c2 ("ARM: dts: update display related nodes for exynos5250-snow") but
>>     was introduced again in the Snow DTS during the merge.
>>
>> I'll post a series that fixes both issues with the following patches:
>>
> I've applied them.
> 
>> Javier Martinez Canillas (2):
>>        ARM: dts: Fix chip select GPIO on smdk5250
>>        ARM: dts: Remove display timings node from exynos5250-snow
>>
>> I see that you already send a pull request to arm-soc maintainers so probably
>> these will be part of the fixes during the 3.18 rc cycle.
>>
> I'll queue them in my third pull-request maybe today :)
> 

Great. It would be awesome also if you can also pick Sjoerd's USB series [0]
which solves an issue with USB on certain configurations.

I looked at your for-next branch but I didn't see those patches there.

> Thanks,
> Kukjin
> 

Thanks a lot and best regards,
Javier

[0]: https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg37045.html
