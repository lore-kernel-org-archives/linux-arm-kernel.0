From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 18 Jun 2012 16:33:11 +0530
Subject: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
In-Reply-To: <alpine.DEB.2.00.1206172225450.10859@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1206172225450.10859@utopia.booyaka.com>
Message-ID: <4FDF0AEF.3080108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 June 2012 09:57 AM, Paul Walmsley wrote:
> On Thu, 14 Jun 2012, Rajendra Nayak wrote:
>
>> OMAP3 has suspend broken in mainline, so I tested it on an
>> older kernel (3.4-rc4 using my RFC series)
>> Idle and OFF mode however seem to be broken for a long time,
>> I wasn;t able to get it working even on 3.4 major.
>> See my logs '3630 Beagle-Xm broken idle/off on 3.4' if
>> I am doing anything wrong. I have CPUidle enabled in the
>> kernel config.
>
> http://www.spinics.net/lists/arm-kernel/msg173688.html

Thanks Paul. I re-tested my branch [1] after applying the 32K sync
timer fix [2] and using timer based wakeup [3] instead of UART.
Both retention and off work fine on my 3630 Beagle-Xm on my CCF
conversion branch.
Updated logs can be found here http://pastebin.com/u/rnayak

regards,
Rajendra

[1] git://github.com/rrnayak/linux.git clk-next-omap-3.5-rc2
[2] http://marc.info/?l=linux-omap&m=134000053229888&w=2
[3] http://marc.info/?l=linux-omap&m=134001387702336&w=2

>
>
> - Paul
