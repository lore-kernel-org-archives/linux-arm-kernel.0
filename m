From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jun 2010 15:41:06 +0100
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <201006032227.56429.marek.vasut@gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006032155.19349.marek.vasut@gmail.com>
	<20100603200109.GC9169@n2100.arm.linux.org.uk>
	<201006032227.56429.marek.vasut@gmail.com>
Message-ID: <20100608144106.GH25370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 10:27:56PM +0200, Marek Vasut wrote:
> btw. Maybe updating the machine registry so it allows pasting/attaching a 
> defconfig with information about kernel version the defconfig corresponds
> with ?

That means persisting with defconfigs, and the problems of keeping
them updated with the kernel.

Moreover, it encourages "one defconfig per machine", which will
cause the number of defconfigs to grow even more - and I don't see
such a system being usable with kautobuild.

Given that it'd mean we still need to solve the problem, I don't see
much point in expanding the machine database to store defconfigs.  It
seems to me it only moves the problem elsewhere, and at the same time
means we end up with two concurrently running systems - the fixed
in-kernel method and the external defconfig file.
