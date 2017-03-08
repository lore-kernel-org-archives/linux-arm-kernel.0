From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Mar 2017 21:58:15 +0000
Subject: [PATCH v1 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <20170308213844.131877-1-thgarnie@google.com>
References: <20170308213844.131877-1-thgarnie@google.com>
Message-ID: <20170308215814.GG21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 01:38:41PM -0800, Thomas Garnier wrote:
> This patch prevents a syscall to modify the address limit of the
> caller. The address limit is kept by the syscall wrapper and restored
> just after the syscall ends.

I would much rather architectures were given the opportunity to code up
checks like this efficiently (iow, inline in the exit path assembly),
rather than having to unconditionally call an additional function on
every syscall, with its register saving overheads.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
