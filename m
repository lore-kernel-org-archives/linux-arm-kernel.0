From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 15:20:58 +0000
Subject: [PATCH 2/3] ARM: sched_clock: support 64-bit counters
In-Reply-To: <514C557F.1090101@gmail.com>
References: <1363055197-17296-1-git-send-email-robherring2@gmail.com>
 <1363055197-17296-3-git-send-email-robherring2@gmail.com>
 <514B1311.20308@codeaurora.org> <514B866A.3010308@gmail.com>
 <514C487B.4020208@codeaurora.org> <514C557F.1090101@gmail.com>
Message-ID: <20130322152057.GE4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 07:58:39AM -0500, Rob Herring wrote:
> The ARM ARM also says the roll-over time must be greater than 40 years.
> So if you have fewer bits, then it needs to run at lower frequency. So I
> think we should be fine.

Well, we have a problem with 32-bit systems in about 19 years time when
32-bit Unix timestamps wrap.  Of course, by that time we'll all be
64-bit won't we. :)

Another issue here is whether it's likely that a system will have an
uptime of 40+ years.  Probably not.  The longest I can think of which
I have come across is the digital public address system on the London
Jubilee Line (Waterloo to Stratford section) which was specified to
have a life of 20 to 30 years... Hmm, I wonder of my Linux based system
activity logger is still in the Stratford PA racks. :)
