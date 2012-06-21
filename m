From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Jun 2012 16:22:41 +0200
Subject: [PATCH] ARM:MXS: Initial support for the Crystalfontz CFA-10036
In-Reply-To: <20120621131138.GA21418@S2101-09.ap.freescale.net>
References: <1340268415-5022-1-git-send-email-maxime.ripard@free-electrons.com>
 <20120621131138.GA21418@S2101-09.ap.freescale.net>
Message-ID: <4FE32E31.2070909@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Le 21/06/2012 15:11, Shawn Guo a ?crit :
> On Thu, Jun 21, 2012 at 10:46:52AM +0200, Maxime Ripard wrote:
>> On the MMC part though, Something odd is going on.  On the first
>> patches I made against 3.4, everything was working fine. With 3.5-rc2
>> though, the MMC never replies to the first CMD52 command sent to
>> it. The pin muxing hasn't changed and has been checked, the card is
>> well detected through the card detect pin, the power enable pin is
>> correctly set to a low level, and so the SD card is correctly
>> powered. The MMC works fine with the exact same kernel on the
>> imx28-evk though.
>>
>> What seems odd to me, is that when booting the board with the 3.4
>> kernel, at boot, the mxs-mmc driver reports a SSP clock of 288MHz,
>> while on 3.5, it reports a 480MHz SSP clock. By looking at the clk
>> driver for the iMX28, there is a comment saying that the 480MHz clock
>> seems to high for SD controlers, and that it should be 288MHz
>> instead. Given that the clock part has changed quite a lot from 3.4 to
>> 3.5, I think it might be a good lead, but hardcoding the SSP clock to
>> 288MHz in the mxs-mmc driver instead of using the clk_get_rate
>> function does not resolve the problem.
>>
>> Also, this problem is seen with both DT-probing and traditionnal
>> probing.
>>
>> Do someone have an idea on what could possibly happen here ?
>>
> Can you try the change below to see if it fixes the problem?

It is indeed working now, thanks a lot :)
I've also tested it on the imx28evk, and it works as well.

You can add by Tested-by I guess :)

We have found that indeed the two registers were inverted compared to
the datasheet, but why was it still working on the iMX28-evk ?

Thanks again,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
