From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Dec 2009 13:13:07 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <4B18F141.7070101@denx.de>
References: <4B18F141.7070101@denx.de>
Message-ID: <20091204131307.GE15887@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 12:23:45PM +0100, Heiko Schocher wrote:
> [4] Log from Demoprogramm, not working

I think this is messed up - this is not from your first script but your
second script which starts four independent read processes.

I determined this because:
(1) the read thread addresses are mostly the same
(2) there are four "Read form in_msg" strings, which you only print
once at the start of the program.
