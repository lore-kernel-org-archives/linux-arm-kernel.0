From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Thu, 14 Jan 2016 13:25:27 +0000
Subject: [PATCH v2] reboot: Backup orderly_poweroff
In-Reply-To: <20160114112354.GA17869@gmail.com>
References: <1452688405-15087-1-git-send-email-j-keerthy@ti.com>
 <20160114090520.GA4351@gmail.com> <569767EC.2010704@ti.com>
 <20160114100913.GB15857@gmail.com> <56977BA7.702@ti.com>
 <20160114112354.GA17869@gmail.com>
Message-ID: <20160114132527.575e0f20@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> If kernel_power_off() is called then the system should power off. No ifs and 
> whens.

Even if it doesn't the watchdog should kill it. 

That is broken on some platforms on the watchdog side as the
watchdog shuts down during our power off callbacks - because the system
firmware is too stupid to reset the watchdog as it powers back up (so
keeps rebooting).

If you watchdog and firmware function properly you shouldn't even have to
care if you crash during the kernel power off.

Alan
