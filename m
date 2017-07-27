From: heinz.wrobel@nxp.com (Heinz Wrobel)
Date: Thu, 27 Jul 2017 14:38:48 +0000
Subject: halting the kernel does not stop the CPU cores?
Message-ID: <VI1PR04MB1662099750F9EAFA0324C6538CBE0@VI1PR04MB1662.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I noticed that when halting the kernel (intentionally or not), the cores effectively go into a while(1) loop and power consumption on larger devices really jumps up significantly to the point where, e.g., a ?crash? turns into ?crash and burn?.

I would assume that if a system is halted, you don?t want to dissipate more power than on a running system but go as silent as low power as reasonable.

Is there any specific reason why the cores would not go into a wfi loop like they do on idle?
The patch to fix this seems to be easy at first glance, but is there a good reason *NOT* to do such a patch and to leave the plain while(1)?

Thanks,

Heinz
