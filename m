From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 18 Feb 2013 23:34:36 +0900
Subject: [BUG arm-soc] mvneta: tx queue done sometimes causes kernel
 panic
In-Reply-To: <20130216022043.65d5c940@skate>
References: <511DE679.5080801@hitachi.com>
 <1360947132.19353.15.camel@edumazet-glaptop> <20130216022043.65d5c940@skate>
Message-ID: <51223BFC.3000408@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2013/02/16 10:20), Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 15 Feb 2013 08:52:12 -0800, Eric Dumazet wrote:
> 
>> Driver is buggy, as TX completion can happen both from ndo_start_xmit()
>> and a timer, and there is no spinlock or appropriate synchro.
> 
> Yes, it is a known issue. I did post a patch fixing the problem on
> netdev@ a while ago [1], but while it was fixing the problem, it wasn't
> considered the right approach. Being busy with other Marvell Armada
> 370/XP developments, I haven't yet had the time to investigate the
> issue again.
> 
> [1] https://patchwork.kernel.org/patch/1941601/

Thank you for pointing that.

I've tried the above patch and found at least this panic
disappeared (even if it was not the right approach).

Thanks again!

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
