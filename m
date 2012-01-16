From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 16 Jan 2012 08:38:00 +0800
Subject: [V3 3/6] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <20120114092704.GP1068@n2100.arm.linux.org.uk>
References: <1322634646-4460-1-git-send-email-jtzhou@marvell.com>
 <20120114092704.GP1068@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZy6XCOX1vLtX7mVxRc2OgwYg-EbaobZ-EExq+=3JU0_uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2012 at 5:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 30, 2011 at 02:30:46PM +0800, Jett.Zhou wrote:
>> Since the regmap of rtc on sa1100, pxa and mmp Marvell soc families are
>> almost the same, so re-arch the rtc-sa1100 to support them.
>
> Err. ?This looks wrong. ?What's the clk stuff doing in here? ?It seems
> to be completely unused by the driver, and then both PXA and SA1100
> end up having to provide a 'dummy' clk structure to satisfy this
> additional useless code.
>
> If it's a case that "every driver must use a clk" then there's a policy
> error somewhere.

Since this RTC driver could be shared among sa1100, pxa, mmp. In
sa1100 and pxa3xx, we don't have this clock. So we use dummy clock
instead. For pxa95x and mmp series, we have this clock.

Best Regards
Haojian
