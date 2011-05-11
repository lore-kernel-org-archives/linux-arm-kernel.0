From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Wed, 11 May 2011 12:31:01 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <20110510143243.3e6f4050@lxorguk.ukuu.org.uk>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com><1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com><034A6447E0D54737B5CEE009A4D20B37@subhasishg><20110509144610.6b4f7090@lxorguk.ukuu.org.uk><3A9C5CD56396439DBF825BB4E5779DB9@subhasishg><20110509145534.2677dfa1@lxorguk.ukuu.org.uk><F0818DA1343E4FF1B3096048359CCC4C@subhasishg>
	<20110510143243.3e6f4050@lxorguk.ukuu.org.uk>
Message-ID: <F0F0851DD515419B962AB1646D333CB1@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Trace all looks fine. I can't see anything else taking the lock so you'll
> need to do a bit more debugging and find out why the spin lock change
> makes the difference and what the real root cause is.

We do not support Modem control signals. So, I use -clocal with stty,
but I observe that still enable_ms and get_mctrl handlers get called.
Is that normal, how can I disable these functions from getting called.

Actually, this same driver works perfectly with 2.6.33 kernel.
With this Kernel I do not observe that these handlers getting called.
So, basically the code path is different.

Further, I only use the port->lock to disable interrupts, so its never 
possible that
while interrupts are disabled by my driver, the TTY is executing anything.

There is another lock in the MFD driver, but that only uses spin_lock/unlock
variant. 
