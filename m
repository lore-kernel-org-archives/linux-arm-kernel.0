From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Oct 2012 03:11:05 +0000 (UTC)
Subject: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling
 hwmod
In-Reply-To: <1350979419.2143.71.camel@sokoban>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1210230745160.32436@utopia.booyaka.com>
 <1350979419.2143.71.camel@sokoban>
Message-ID: <alpine.DEB.2.00.1210300309190.12697@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Tue, 23 Oct 2012, Tero Kristo wrote:

> Looks good to me. Only reason I pushed the reset wait to the end of the
> function was a minimal potential timing optimization. As the beginning
> of the function will write a register, it will consume a bit of time
> (especially if in 32k domain), so it can maybe save a single register
> read in the delay loop if ordered that way.

Ah, OK.

> Your way is probably safer, it might cause problems in some cases if the
> config is written before reset has completed (can it?)

Not sure, but seems to make sense to wait until the reset is done before 
doing anything to the IP block's registers.  Queuing for 3.7-rc fixes,


- Paul
