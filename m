From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 24 Sep 2018 08:55:29 +0200
Subject: [PATCH 0/2] STM32: Fixes for 4.19 cycle
In-Reply-To: <20180923123438.kyvxpeqq6q6xo6cs@localhost>
References: <1537461257-2940-1-git-send-email-alexandre.torgue@st.com>
 <20180923123438.kyvxpeqq6q6xo6cs@localhost>
Message-ID: <d952b14a-644e-a067-9615-f0d35f370893@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

On 09/23/2018 02:34 PM, Olof Johansson wrote:
> Hi Alexandre,
> 
> On Thu, Sep 20, 2018 at 06:34:15PM +0200, Alexandre Torgue wrote:
>> Hi Arnd, olof and Kevin
>>
>> Those 2 patches fixe the same issue on 4.19-rc: a bad usage of the mdma
>> binding inside stm32mp157c.dts file. Can you please add them as fixe for 4.19 ?
> 
> The patches only mention removing unused property contents, not what the bug is
> that it fixes (or if it's even causing any problems). Care you clarify?

Sure.
Concerning SPI patch: without this patch, DMA request will fail but 
there will be no crash because SPI will switch in interrupt mode.
Concerning HASH one, it's just to align DT with dt-bindings documentation.
Regarding the minor issue that they fix I could understand that you 
postpone the merge of those two patches for 4.20.

Regards
Alex

> 
> If it's just fixing inaccurate DT that isn't used, then it's not something we
> urgently need to fix in 4.19 and it can wait for 4.20.
> 
> 
> Thanks,
> 
> 
> -Olof
> 
