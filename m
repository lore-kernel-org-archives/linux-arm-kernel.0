From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Tue, 17 Dec 2013 12:26:12 +0000
Subject: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
In-Reply-To: <20131217121358.GM6691@S2101-09.ap.freescale.net>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
 <20131217105347.75954ad3@ipc1.ka-ro>,
 <20131217121358.GM6691@S2101-09.ap.freescale.net>
Message-ID: <D8D77E89-793D-4A52-AB38-769BC47BAF33@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Sent from Anson's iPhone

> ? 2013?12?17??20:13?"Shawn Guo" <shawn.guo@linaro.org> ???
> 
> On Tue, Dec 17, 2013 at 10:53:47AM +0100, Lothar Wa?mann wrote:
>>>> +    if (soc_opp_index >= soc_opp_count) {
>>> 
>>> Can soc_opp_index be possibly greater than soc_opp_count?  Otherwise,
>>> the condition check below is good enough?
>>> 
>>>    if (soc_opp_index == soc_opp_count)
>> it doen't harm to be on the safe side and use >= anyway!
> 
> Well, it may confuse reader.  At least, it took me some time understand
> how that ">" condition will happen.  And it turns out never.

it does not matter now, since in V2 patch, i use index passed from
freq table, no need to look up the soc opp. please help review V2 patch set, thanks.

Anson.


> 
> Shawn
> 
