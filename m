From: max.schwarz@online.de (Max Schwarz)
Date: Tue, 15 Apr 2014 02:19:31 +0200
Subject: Rockchip RK3188 I2C driver
Message-ID: <3748421.ND1tAjvgKS@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

I just wanted to advertise that I'm currently working on a driver for the 
native I2C adapters in the RK3188. I want to avoid duplicating work, and I 
just saw that you also started on one in your github repository (nice job on 
the clock driver and ethernet support, by the way!).

If you want to peek, my status quo is here:
https://github.com/xqms/linux.git topic/i2c-rk3x

The driver is almost finished, it's just missing support for long transfers 
(>32 bytes) and a bit of cleanup. Communication with the ACT8846 works without 
problems. It depends on your clock driver though, so I'll wait with a patch 
until that is finished, right?

By the way, I got my arc-emac working correctly only after re-setting the mac 
address from userspace (ifconfig eth0 hw ether ...). A simple fix for that is 
also in my github repo (topic/emac-addr-fix), if you are interested.

Cheers,
  Max
