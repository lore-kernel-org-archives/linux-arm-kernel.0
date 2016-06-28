From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 28 Jun 2016 13:55:36 +0200
Subject: [PATCH] ARM: sti: Implement dummy L2 cache's write_sec
In-Reply-To: <20160628094914.GI1041@n2100.armlinux.org.uk>
References: <1467106837-20996-1-git-send-email-patrice.chotard@st.com>
 <20160628094914.GI1041@n2100.armlinux.org.uk>
Message-ID: <577265B8.5030009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

On 06/28/2016 11:49 AM, Russell King - ARM Linux wrote:
> On Tue, Jun 28, 2016 at 11:40:37AM +0200, patrice.chotard at st.com wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> This patch implements the write_sec callback that handle PL310
>> secure registers writes.
>> This callback is just a stub for now, to avoid system crash.
>> Later, it could handle SMC calls so that TZ handles the needed writes.
> Is there much point having the L2 cache DT node enabled if you have
> no support for the writes, which are required for the hardware to be
> enabled?
>
It's similar to what has been done for ux500 machine, in non secure 
mode, we
can't write in L2 cache secure registers.

Patrice
