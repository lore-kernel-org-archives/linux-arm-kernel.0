From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Mon, 7 Mar 2016 14:26:14 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <56DD7593.5060003@suse.de>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <56DD7172.4000707@suse.de> <2714888.1DdqvJZ8cb@diego>
 <56DD7593.5060003@suse.de>
Message-ID: <56DD8176.2080603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas, Heiko,

On 3/7/2016 1:35 PM, Andreas F?rber wrote:
> Hi Heiko,
>
> Am 07.03.2016 um 13:24 schrieb Heiko St?bner:
>> Am Montag, 7. M?rz 2016, 13:17:54 schrieb Andreas F?rber:
>>> Am 06.03.2016 um 20:53 schrieb Andreas F?rber:
>>>> On next-20160304 the GMAC seems to have regressed, it no longer finds the
>>>> PHY:
>>>>
>>>> libphy: PHY stmmac-0:ffffffff not found

snps,phy-addr is not correct. Can you check it?

In the stmmac_mdio if this is not passed as parameter the bus should
be scanned and the first IDs found should select the right address.
I suppose in your box there is a real transceiver, so maybe the patch
from Gabriel is not actually necessary.

>>>> eth0: Could not attach to PHY
>>>> stmmac_open: Cannot attach to PHY (error: -19)
>>>
>>> Still with us in next-20160307. CC'ing stmmac maintainers.

peppe

>>
>> do you remember from what revision you rebased away from, when it was still
>> working (as a known-good state)?
>
> Hm, next-20160111 possibly... leaving all the 5 days and 4 days ago
> changes as candidates ("stmmac: share reset function between dwmac100
> and dwmac1000" .. "stmmac: Fix 'eth0: No PHY found' regression").
>
> Regards,
> Andreas
>
