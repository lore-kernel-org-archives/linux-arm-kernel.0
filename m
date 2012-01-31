From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2012 17:59:05 +0000
Subject: reboot/suspend regression: hx4700 freezes under linux-3.3-rc1
In-Reply-To: <1328030890.46053.YahooMailClassic@web29001.mail.ird.yahoo.com>
References: <1328030890.46053.YahooMailClassic@web29001.mail.ird.yahoo.com>
Message-ID: <20120131175905.GA8338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 05:28:10PM +0000, Paul Parsons wrote:
> Both reboot (via reboot(RB_AUTOBOOT)) and suspend (via apm --suspend)
> freeze my hx4700 under linux-3.3-rc1. They both worked under linux-3.2.
> 
> I presume that at least the reboot freeze is related to the restart
> changes back in November. Can anyone suggest anything obvious I
> should check? If not I'll attempt to get console output on to the
> screen, which may or may not help.

I'd also suggest trying to bisect them to find out exactly which
commit caused the problem.

You should be able to just do a bisect between v3.2-rc1 and
f88b8979d26615ce68772cebc85c3b556571afca
ARM: restart: remove the now empty arch_reset()

However, you might need 28f9a9294a37ddbc1d821782afc8754eed4bce4e
applied to be able to build.
