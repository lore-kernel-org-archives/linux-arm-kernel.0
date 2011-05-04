From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 May 2011 15:11:53 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <15AD189F851849F69A011B6F4D1DDB6C@subhasishg>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<201104271525.28512.arnd@arndb.de>
	<15AD189F851849F69A011B6F4D1DDB6C@subhasishg>
Message-ID: <201105041511.54095.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 May 2011, Subhasish Ghosh wrote:
> CAN requires mail box IDs to be programmed in. But, the socket
> CAN subsystem supports only software filtering of the mail box IDs.
> 
> So, the mail box IDs programmed into socket CAN during initialization
> does not propagate into the hardware. This is planned to be a future
> implementation in Socket CAN.
> 
> In our case, we support hardware filtering, to work around with this,
> Wolfgang (Socket CAN owner) suggested that we implement
> this using sysfs.
> 
> These setting are not for debugging, but to program the mail box IDs
> into the hardware. 

Ok, I see. Can you point me to that discussion?

Wolfgang, I'm a bit worried by the API being split between sockets and sysfs.
The problem is that once the sysfs API is established, users will start
relying on it, and you can no longer migrate away from it, even when
a later version of the Socket CAN also supports setting through a different
interface. What is the current interface to set mail box IDs in software?
How hard would it be to implement that feature in Socket CAN?

Is that something that Subhasish or someone else could to as a prerequisite
to merging the driver?

	Arnd
