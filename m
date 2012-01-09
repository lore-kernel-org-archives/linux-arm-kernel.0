From: rusko.peter@prolan.hu (Peter Rusko)
Date: Mon, 9 Jan 2012 15:07:44 +0100
Subject: MX28 fec clock frequency
In-Reply-To: <20120108033238.GA19721@S2101-09.ap.freescale.net>
References: <4F06D643.6080602@prolan.hu>
 <20120108033238.GA19721@S2101-09.ap.freescale.net>
Message-ID: <4F0AF4B0.4030403@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-01-08 04:32, Shawn Guo wrote:
> Hi Peter,
>
> On Fri, Jan 06, 2012 at 12:08:51PM +0100, Peter Rusko wrote:
>> Hi all,
>>
>> I'm trying to get the fec clock frequency on the i.MX28 processor. I0
>> need it for a PTP clock and it seems that I get a wrong value:
>> clk_get_rate returns 151578947.
>>
>
> The ptp clock (CLK_ENET_TIME) was missed from the initial imx28 clock
> support.  The fec_clk which is one child of hbus_clk (151 MHz) is
> taken as MDIO clock in fec driver.
>

I'm working on a ptp driver now and I can't deal with the clock.

I've added the CLK_ENET_TIME clock and set it to 40MHz. It should give a
25ns period for the counter in ptp. However the ptp clock is too slow.

If i increase the number (up to the maximum, which is 0x7f), the clock
is still slower then normal. It's like the CLK_ENET_TIME frequency is
less then I think. What can be the problem?

I've attached a patch.

Regards,
-- 
Rusk? P?ter
Fejleszt?m?rn?k

Prolan Zrt. / Prolan Co.
Hungary 2011 Budakal?sz, Szentendrei ?t 1-3.
Tel./Phone: +36 20 954 3118
Fax: +36 26 540 420
E-mail: rusko.peter at prolan.hu
Web: www.prolan.hu
Timezone:CET
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fec_ptp.patch
Type: text/x-patch
Size: 19053 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120109/09c41f10/attachment-0001.bin>
