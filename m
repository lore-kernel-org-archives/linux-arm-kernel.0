From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 21:52:39 +0000
Subject: [PATCH 09/11] ep93xx: Move crunch code to mach-ep93xx directory
In-Reply-To: <4F109F45.9020105@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-10-git-send-email-rmallon@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F001F3F99EBB11@AUSP01VMBX24.collaborationhost.net>
 <4F109F45.9020105@gmail.com>
Message-ID: <20120113215239.GG1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2012 at 08:16:53AM +1100, Ryan Mallon wrote:
> I was hoping that Russell would make some comment here about whether
> moving this file out of arch/arm/kernel is okay to do.

I have no objection to SoC specific code moving out of arch-generic areas
into SoC specific areas - provided it doesn't cause any abonimations!

> I assume it had
> some reason to be there in the first place. I have only done build
> testing so far since I don't have any ep93xx hardware to test on, and
> have never actually used crunch anyway.

I suspect it was there because the iwmmxt stuff was also in that directory,
and at the time we didn't have the notifier in place to be able to properly
broadcast events that ISA extensions needed to react to context switching
etc.

Now that we do have all that in place, I don't think there's much reason
it lives in arch/arm/kernel.
