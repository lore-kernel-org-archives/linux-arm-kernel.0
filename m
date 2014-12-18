From: xerofoify@gmail.com (nick)
Date: Thu, 18 Dec 2014 08:35:10 -0500
Subject: Weird/Unneeded call to msleep in exynos_mipi_dsi_wr_data in
 exynos_mipi_dsi_common.c
In-Reply-To: <5492ABE7.1060900@samsung.com>
References: <54920A54.2060608@gmail.com> <5492ABE7.1060900@samsung.com>
Message-ID: <5492D80E.3010906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof,
If we look at the code for this function, it already is handling the data correctly. In addition  the locks 
seem to be better protection then msleep. Further more is no reason for this delay as we are neither resetting 
the hardware or waiting for the hardware here so why is it needed? I don't have Exynos based hardware lying
around through to test it.
Nick
On 2014-12-18 05:26 AM, Krzysztof Koz?owski wrote:
> On 17.12.2014 23:57, nick wrote:
>> Greetings Fellow Maintainers,
>> Sorry if I wasting your time but it seems there is a unneeded call to msleep
> 
> Hi,
> 
> 1. Please describe exactly why do you think this is not needed.
> 2. Do you have Exynos-based hardware to test your changes?
> 
> Best regards,
> Krzysztof
> 
>> and rather trivial fix me to fix in the file,exynos_mipi_dsi_common.c for the function,exynos_mipi_dsi_wr_data . If there is a valid reason for this call please let me known when any of you  have some free time. Otherwise I will send in a patch to remove this unneeded
>> call to msleep.
>> Thanks,
>> Nick  
> 
> 
