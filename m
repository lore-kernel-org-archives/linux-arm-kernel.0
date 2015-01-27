From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jan 2015 22:43:25 +0000
Subject: [PATCH v3 03/13] pm: at91: Workaround DDRSDRC self-refresh bug
 with LPDDR1 memories.
In-Reply-To: <6740d1ada0cb4c8bbf765728c7443918@EMAIL.axentia.se>
References: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
 <1422338006-3371-1-git-send-email-wenyou.yang@atmel.com>
 <54C7675D.8000204@cogentembedded.com>
 <6740d1ada0cb4c8bbf765728c7443918@EMAIL.axentia.se>
Message-ID: <20150127224325.GR26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 09:55:52PM +0000, Peter Rosin wrote:
> I have now checked the assembler output, and apparently it mends the
> input, just as I thought. That might be a fluke, of course, or it might be a
> deliberate shorthand when the destination register is the same as the
> following operand?

I believe it is because we have the assembler in unified asm mode, where
such things are legal (due to Thumb2.)  That means these two are
legal:

	orr	r2, #const
	orr	r2, r2, #const

and equivalent in this context.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
