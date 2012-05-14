From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Mon, 14 May 2012 17:01:08 +0800
Subject: [PATCH 2/2] mfd: anatop: permit adata be NULL when access register
In-Reply-To: <20120514084810.GD20367@S2100-06.ap.freescale.net>
References: <1336870794-6351-1-git-send-email-richard.zhao@freescale.com>
 <1336870794-6351-2-git-send-email-richard.zhao@freescale.com>
 <20120514035137.GB20367@S2100-06.ap.freescale.net>
 <20120514080835.GB31985@opensource.wolfsonmicro.com>
 <20120514084810.GD20367@S2100-06.ap.freescale.net>
Message-ID: <4FB0C9D4.2060409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2012?05?14? 16:48), Shawn Guo wrote:
> On Mon, May 14, 2012 at 09:08:36AM +0100, Mark Brown wrote:
>> On Mon, May 14, 2012 at 11:51:38AM +0800, Shawn Guo wrote:
>>
>>> From what I see, it's reasonable.  Then the immediate question I have
>>> is, should we remove "struct anatop *adata" from anatop_read_reg and
>>> anatop_write_reg completely?
>>
>> Given the way these things tend to go it's probably guaranteeing that
>> your next round of SoCs will have two register compatible anatop blocks :)
> 
> Considering anatop block tends to be a container of misc hardware
> control bits, I haven't really seen any possibility that the future
> SoCs will have multiple anatop blocks.
> 

Hi Shawn,

I think what the concern is we probably don't want several
non-continuous memory blocks of misc hardwares.
If we look into the current registers in anatop, it is really sparse.
Several regulators are using non-continuous address and the thermals are
also using different addresses. If the addresses are continuous then we
don't need the mfd driver.

We've already told Lily Zhang from Freescale and she promises to report
this problem to some inner team.

Yours Sincerely,
Paul
