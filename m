From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2009 11:21:48 +0100
Subject: About the system call named "sys_mount".
In-Reply-To: <1C70663C229ECE40981BAC25C6482BC4072EABEA@SZHOMailBE01.skyworth.com>
References: <1C70663C229ECE40981BAC25C6482BC4072EABEA@SZHOMailBE01.skyworth.com>
Message-ID: <20091019102148.GA7412@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 05:57:21PM +0800, ??? wrote:
> if there is no potential risk, the speed of "mount" command would be
> improved greatly.  Tell me plz if there is problem. thax.

1. You're risking a kernel oops, caused by direct dereferencing of
   user pointers
2. The cost of copying parameters in sys_mount has nothing to do with
   the speed - the biggest issue will be accessing the media itself.
