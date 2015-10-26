From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Oct 2015 10:40:36 +0000
Subject: some question about LR of task_pt_regs
In-Reply-To: <CADUS3o=F4diU-xG8DsE6c+Zm6juQetJ0kmMtKNdz8pOXBRxq=A@mail.gmail.com>
References: <CADUS3o=F4diU-xG8DsE6c+Zm6juQetJ0kmMtKNdz8pOXBRxq=A@mail.gmail.com>
Message-ID: <20151026104036.GA8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 05:55:29PM +0800, yoma sophian wrote:
> hi all:
> I use linaro toolchain which libc is compile in thumb mode and if any
> user mode program call sleep, the lr of its task_pt_regs will be 0, no
> matter how many function level I called.

It depends on the userspace code at the time that the system call is
made.  If it's setting LR to zero, then you'll read zero.  I don't
think it has anything to do with the toolchain either.  Check the
libc code around the site for the system call.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
