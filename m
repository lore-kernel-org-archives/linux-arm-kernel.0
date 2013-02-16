From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 16 Feb 2013 02:20:43 +0100
Subject: [BUG arm-soc] mvneta: tx queue done sometimes causes kernel panic
In-Reply-To: <1360947132.19353.15.camel@edumazet-glaptop>
References: <511DE679.5080801@hitachi.com>
 <1360947132.19353.15.camel@edumazet-glaptop>
Message-ID: <20130216022043.65d5c940@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 15 Feb 2013 08:52:12 -0800, Eric Dumazet wrote:

> Driver is buggy, as TX completion can happen both from ndo_start_xmit()
> and a timer, and there is no spinlock or appropriate synchro.

Yes, it is a known issue. I did post a patch fixing the problem on
netdev@ a while ago [1], but while it was fixing the problem, it wasn't
considered the right approach. Being busy with other Marvell Armada
370/XP developments, I haven't yet had the time to investigate the
issue again.

[1] https://patchwork.kernel.org/patch/1941601/

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
