From: utx@penguin.cz (Stanislav Brabec)
Date: Wed, 27 Apr 2011 11:46:43 +0200
Subject: [RFC PATCH v2 1/3] PM / Core: suspend_again callback for
	device PM.
In-Reply-To: <BANLkTi=QDjBtY2WypXjYzyAOUGYjf_oRvw@mail.gmail.com>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426210627.GA28033@elf.ucw.cz> <201104262346.58046.rjw@sisk.pl>
	<201104270032.42046.rjw@sisk.pl>
	<BANLkTi=QDjBtY2WypXjYzyAOUGYjf_oRvw@mail.gmail.com>
Message-ID: <1303897603.4431.16.camel@oct.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:

> As long as sysdevs are resumed and some devices/subsystems (I2C-PMIC,
> ADC, and RTC in my cases) can be selectively resumed and suspended, it
> is fine.
> Thus, your "alternative" suggestion is perfect with me. Actually, this
> is almost going back to the original hack. =)
> 
> I'll submit next revision with platform_suspend_ops later.

Does kernel have something like "sleepy task" interface, e. g. special
mode that is triggered by some sort of interrupt and instead of going to
perform full resume, it just lets a hook to wake up "manually" needed
devices, perform the "sleepy task" and then tell the system whether full
resume is requested?

It can fit for Zaurus battery charging monitoring - timer interrupt
needs to wake just the SPI bus.

But I can imagine a GPS logger using such interface to save energy -
serial interrupt semi-wakes the system each second, but will not go to
do full resume. It just processes NMEA sentence and buffers the result.
Only if buffer becomes full, it issues full resume and writes data
somewhere.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec at suse.cz
Lihovarsk? 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/
