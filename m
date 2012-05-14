From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Mon, 14 May 2012 21:26:57 +0800
Subject: [PATCH 2/2] mfd: anatop: permit adata be NULL when access register
In-Reply-To: <20120514094357.GF20367@S2100-06.ap.freescale.net>
References: <1336870794-6351-1-git-send-email-richard.zhao@freescale.com>
 <1336870794-6351-2-git-send-email-richard.zhao@freescale.com>
 <20120514035137.GB20367@S2100-06.ap.freescale.net>
 <20120514080835.GB31985@opensource.wolfsonmicro.com>
 <4FB0C9D4.2060409@linaro.org>
 <20120514094357.GF20367@S2100-06.ap.freescale.net>
Message-ID: <4FB10821.4000004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2012?05?14? 17:43), Shawn Guo wrote:
> On Mon, May 14, 2012 at 05:01:08PM +0800, Ying-Chun Liu (PaulLiu) wrote:
>> I think what the concern is we probably don't want several
>> non-continuous memory blocks of misc hardwares.
>> If we look into the current registers in anatop, it is really sparse.
>> Several regulators are using non-continuous address and the thermals are
>> also using different addresses. If the addresses are continuous then we
>> don't need the mfd driver.
>>
> I do not quite follow that.  The reason we need mfd driver isn't because
> we do not want to both regulator and thermal drivers to map and access
> the same address on their own which may have synchronization issue?
> 

Not sure about the synchronization issue. But currently thermal driver
in Linaro kernel do map and access the same address on its own now. It
is not a device driver yet and just access the address directly and
work. It seems to me that each different type of misc devices in Anatop
just work alone.

So let's go back to the patch. Why do we need this modification? Anatop
thermal driver can be written as a device driver and don't need this
patch. And we might get benefits when thermal driver written in this
way. Especially some boards do not have a correct fuse data. Any real
use cases of this patch?

Yours Sincerely,
Paul
