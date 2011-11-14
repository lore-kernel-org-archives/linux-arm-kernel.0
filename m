From: alan@linux.intel.com (Alan Cox)
Date: Mon, 14 Nov 2011 12:07:45 +0000
Subject: [PATCH] RS485: fix inconsistencies in the meaning of some
 variables
In-Reply-To: <4EC062B7.2090100@griffin.net>
References: <4E492CFF.7040905@pwrnet.de> <20110822211832.GA8023@kroah.com>
 <4EB3A009.10502@evidence.eu.com> <4EB8F6B9.6010008@atmel.com>
 <4EB90902.4030200@evidence.eu.com>
 <20111108134804.07095c5d@lxorguk.ukuu.org.uk>
 <20111108142432.GA11293@kroah.com>
 <4EBA9385.7010806@evidence.eu.com>
 <20111113215318.GA2966@pengutronix.de>
 <4EC062B7.2090100@griffin.net>
Message-ID: <20111114120745.376729c4@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Perhaps the RTS toggle after transmit delay needs to be large, and 
> they'd rather do it in userspace than block in the driver. I also
> recall a protocol that would send a master assertion command and hold
> on to RTS afterwards. I can easily imagine needing to quickly

Appletalk does this for one. Some protocols use it for priming low cpu
power receivers. You fire a header message at the target which fits
into its serial fifo, it then responds and can sit in a tight loop
getting the following frame data.

Alan
