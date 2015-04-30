From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 30 Apr 2015 08:43:03 -0700
Subject: [PATCH 1/1] ARM: dts: Make DP a consumer of DISP1 power domain on
 Exynos5420
In-Reply-To: <126501d082dd$af818a30$0e849e90$@kernel.org> (Kukjin Kim's
 message of "Thu, 30 Apr 2015 09:36:23 +0900")
References: <1428870659-5525-1-git-send-email-javier.martinez@collabora.co.uk>
 <552F6750.6020306@collabora.co.uk> <55417810.6070202@collabora.co.uk>
 <126501d082dd$af818a30$0e849e90$@kernel.org>
Message-ID: <7hegn1pqpk.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene@kernel.org> writes:

> Javier Martinez Canillas wrote:
>> 
>> Hello Kukjin,
>> 
> Hi,
>
>> On 04/16/2015 09:40 AM, Javier Martinez Canillas wrote:
>> >
>> > On 04/12/2015 10:30 PM, Javier Martinez Canillas wrote:
>> >> Commit ea08de16eb1b ("ARM: dts: Add DISP1 power domain for exynos5420")
>> >> added a device node for the Exynos5420 DISP1 power domain but dit not
>> >> make the DP controller a consumer of that power domain.
>> >>
>> >> This causes an "Unhandled fault: imprecise external abort" error if the
>> >> exynos-dp driver tries to access the DP controller registers and the PD
>> >> was turned off. This lead to a kernel panic and a complete system hang.
>> >>
>> >> Make the DP controller device node a consumer of the DISP1 power domain
>> >> to ensure that the PD is turned on when the exynos-dp driver is probed.
>> >>
>> >> Fixes: ea08de16eb1b ("ARM: dts: Add DISP1 power domain for exynos5420")
>> >> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> >
>> > Any comments about this patch?
>> >
>> > It's very trivial but fixes a very important regression on Exynos5420 boards
>> > with display panel and Peach Pit and Pi have been broken since next-20150401.
>> >
>> > This [0] is the Peach Pit boot log with yesteday's linux-next for example.
>> >
>> > Best regards,
>> > Javier
>> >
>> > [0]: http://arm-soc.lixom.net/bootlogs/next/next-20150415/pit-arm-exynos_defconfig.html
>> >
>> 
>> It has been many weeks since this patch has been posted and linux-next
>> is still broken:
>> 
>> http://arm-soc.lixom.net/bootlogs/next/next-20150429/pi-arm-exynos_defconfig.html
>> 
>> Could you please apply $subject to fix the imprecise external abort issue.
>> 
> Sure I'll in this weekend.
>
> Thanks for your gentle reminder ;-)

Tested-by: Kevin Hilman <khilman@linaro.org>

I confirm that this patch fixes the imprecise aborts (and sometimes
kernel panics) that I'm seeing on exynos5800-peach-pi with linux-next.

Kevin
