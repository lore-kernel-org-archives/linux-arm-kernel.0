From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Jun 2013 09:15:14 +0100
Subject: [PATCH V2] serial: imx: enable the clocks only when the uart
 is used
In-Reply-To: <51B2CDAF.3050104@freescale.com>
References: <1370311173-15019-1-git-send-email-b32955@freescale.com>
 <20130608060116.GB20780@S2101-09.ap.freescale.net>
 <51B2CDAF.3050104@freescale.com>
Message-ID: <20130608081514.GH18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 02:22:39PM +0800, Huang Shijie wrote:
> ? 2013?06?08? 14:01, Shawn Guo ??:
>> Running linux-next 20130607, I just found that the serial console stops
>> working due to this patch.  I think the clocks need to be enabled for
>> console as well.
> could you tell me the board?
> i tested on imx6q-sabreauto boards, the console is ok.

Take a look at amba-pl011.c to see how to deal with the console and clk API
correctly in serial drivers.
