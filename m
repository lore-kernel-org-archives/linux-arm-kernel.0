From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 18 Dec 2013 15:53:45 +0400
Subject: [PATCH 2/5] arm: shmobile: r7s72100: add i2c clocks
In-Reply-To: <20131218114351.GD3314@katana>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-3-git-send-email-wsa@the-dreams.de>
 <52B1892B.1020806@cogentembedded.com> <20131218114351.GD3314@katana>
Message-ID: <52B18CC9.8090200@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-12-2013 15:43, Wolfram Sang wrote:

>>> @@ -173,6 +179,10 @@ static struct clk_lookup lookups[] = {
>>>   	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),

>>>   	/* ICK */
>>> +	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
>>> +	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
>>> +	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
>>> +	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),

>>     These belong to some other place, the group marked by /* ICK */
>> is only for CLKDEV_ICK_ID().

> So, I'll create a /* DEV */ prefix?

    I really don't know. Other places have /* MSTP */ comment in this case 
despite all clocks, CLKDEV_DEV_ID() and CLKDEV_ICK_ID() are really MSTP 
clocks. I considered the idea of separating CLKDEV_ICK_ID() under /* ICK */ 
comment silly from the very start but Simon didn't listen to me.

WBR, Sergei
