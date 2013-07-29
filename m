From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 29 Jul 2013 10:00:01 +0200
Subject: [PATCH v2 00/42] ARM: at91: move to common clk framework
In-Reply-To: <51F2A556.8020109@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
 <51F28370.6050304@gmail.com> <51F2996B.6000406@overkiz.com>
 <51F2A556.8020109@overkiz.com>
Message-ID: <CACQ1gAgw-v3z_sWcsk7SqFFW-ERLjS0RS5GTgAdd5Y1tj3Z1FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/26 boris brezillon <b.brezillon@overkiz.com>:
> On 26/07/2013 17:44, boris brezillon wrote:
> I found 2 bugs:
> 1) the main frequency ready test in recalc_rate function is wrong
> 2) the common clk framework uses the first match for dt clk registration
>    and main clk has this compatible property:
>    compatible = "atmel,at91rm9200-clk-main", "fixed-clock";
>    As a result the main clk is always bound to the fixed-clock driver
>    which set the clock frequency to 0 if 'clock-frequency' property is
>    missing.
>
> These bugs will be fixed in next version.
> Tell me if you want need thesse patches for testing purpose.

Hi Boris,

I tested your patch, the clock is not at 0 anymore:
AT91: PIT: mck rate = 8333333

And it's booting correctly.
There's a small bug I found in the at91sam9x5 dtsi file (ssc id is 28,
not 27). (patch attached)

And yes, I could use your patches for some more tests !

Thanks,

Richard.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-at91-dt-at91sam9x5-fix-wrong-SSC-clock-ID.patch
Type: application/octet-stream
Size: 769 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/d3e6ee98/attachment.obj>
