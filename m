From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 05 Apr 2013 20:30:00 +0400
Subject: [PATCH 5/8] rcar-phy: correct base address
In-Reply-To: <20130405004356.GP29203@verge.net.au>
References: <201304050305.15517.sergei.shtylyov@cogentembedded.com>
 <20130405004356.GP29203@verge.net.au>
Message-ID: <515EFC08.8000308@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-04-2013 4:43, Simon Horman wrote:

>> The memory region that is used by the driver overlaps EHCI and OHCI register
>> regions for absolutely no reason now  -- fix it by adding offset of 0x800 to
>> the base address, changing the register #define's accordingly. This has extra
>> positive effect that we now can use devm_ioremap_resource().

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> As per my comment regarding patch 4, I wonder if this
> could be split into a driver patch and an SoC patch.

    Absolutely not. That'll break bisection.

WBR, Sergei
