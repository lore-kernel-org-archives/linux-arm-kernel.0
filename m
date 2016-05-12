From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 May 2016 11:21:42 +0200
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <20160512091758.GB11226@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <4989778.Fs81NJurjH@wuerfel>
 <20160512091758.GB11226@e104818-lin.cambridge.arm.com>
Message-ID: <2733875.IzutTZKHMc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 May 2016 10:17:58 Catalin Marinas wrote:
> On Wed, May 11, 2016 at 09:30:07PM +0200, Arnd Bergmann wrote:
> > On Wednesday 11 May 2016 17:59:01 Catalin Marinas wrote:
> > 
> > I don't think the shifts are a problem, the main downside would be
> > the limit to 44 bits of file offsets (16TB files), but it's also
> > unclear if that is a practical problem at all. If it is, we run
> > into the same problem on all other 32-bit architectures too.
> 
> I hope people are seriously thinking of moving to an LP64 ABI if they
> have such large file offset needs.

Good point. 44 bits of file size is certainly enough for mmap()
on a 32-bit task: you would only be able to map a very small fraction
of the file anyway, and if you want to map larger files, and should
move to 64-bit tasks long before this becomes a limitation.

	Arnd
