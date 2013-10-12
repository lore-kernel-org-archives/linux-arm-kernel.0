From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 11 Oct 2013 19:47:37 -0700
Subject: [PATCH] wdt: sunxi: Fix section mismatch
In-Reply-To: <20131011191527.GO3041@lukather>
References: <1380982817-10234-1-git-send-email-maxime.ripard@free-electrons.com>
 <20131011191527.GO3041@lukather>
Message-ID: <5258B849.7060709@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2013 12:15 PM, Maxime Ripard wrote:
> Hi Wim,
>
> On Sat, Oct 05, 2013 at 04:20:17PM +0200, Maxime Ripard wrote:
>> This driver has a section mismatch, for probe and remove functions,
>> leading to the following warning during the compilation.
>>
>> WARNING: drivers/watchdog/built-in.o(.data+0x24): Section mismatch in
>> reference from the variable sunxi_wdt_driver to the function
>> .init.text:sunxi_wdt_probe()
>> The variable sunxi_wdt_driver references
>> the function __init sunxi_wdt_probe()
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> It would be great if it could go in 3.12.
>

Hi Maxime,

Just wondering - is this a nuisance or does it cause a real problem ?

> Do you want to take it, or can I merge it through my tree, with your
> Acked-by?
>

In addition to this patch, the following two would also be good to have in 3.12.
	http://www.spinics.net/lists/linux-watchdog/msg02867.html
	http://www.spinics.net/lists/linux-watchdog/msg02950.html

Thanks,
Guenter
