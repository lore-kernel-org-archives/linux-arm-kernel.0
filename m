From: dev.c0debabe@gmail.com (Stefan Schoenleitner)
Date: Sat, 31 Oct 2009 15:24:43 +0100
Subject: at91sam9260 on linux 2.6.31 with at91 patchset: UART looses bytes
	when receiving packets
In-Reply-To: <20091031141616.GA28141@n2100.arm.linux.org.uk>
References: <594305.67002.qm@web84306.mail.re1.yahoo.com>
	<4AEC1D8D.7020209@gmail.com> <4AEC4316.3050008@gmail.com>
	<20091031141616.GA28141@n2100.arm.linux.org.uk>
Message-ID: <4AEC48AB.7050008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:

> You're not touching the iflags at all, so ixon could be set:

You're absolutely right, I forgot the iflags.
I set it to 0 now and it works ! :)

> In any case, there's a far easier way to do this - cfmakeraw().  It'll
> avoid bugs such as forgetting to set the iflags correctly.  This
> modifies the termios as.

Thanks I'll better use cfmakeraw() then.

For my code I was reading the linux serial programming howto which
unfortunately does not mention cfmakeraw().
This is the reason why I was doing it this way (and forgot to set the
iflags)

> If you're also setting the baud rate, you should look at cfsetispeed() and
> cfsetospeed() as well.

This is what I was using already, it works well.

So thank you for the help and the valuable information you provided, my
code works now.

cheers,
stefan
