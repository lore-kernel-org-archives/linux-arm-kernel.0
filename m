From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 21:30:55 +0200
Subject: Get machine type in user space
In-Reply-To: <CABp-a4cUbwXEGPUQBjGRnNR+X91j1qGQigS=KYTZ1fZ2ZGzQtA@mail.gmail.com>
References: <CABp-a4cUbwXEGPUQBjGRnNR+X91j1qGQigS=KYTZ1fZ2ZGzQtA@mail.gmail.com>
Message-ID: <201306202130.55247.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Per Strandh wrote:
> I work for a company that develops our own arm-based embedded linux
> products. (both hardware and software)
> 
> My question is about the "machine type" parameter that is passed from
> the  bootloader to the kernel.
> 
> If the kernel supports more than one "machine type", the the one that
> are specified by the bootloader will be choosen.
> If the kernel only supports one "machine type" that will always be choosen.
> 
> Question:
> Is it possible from user-space to find out the "machine type" that was
> passed from the bootloader?
> I know that in /proc/cpuinfo it is possible to see that "name" of the
> choosen "machine type", but not if it was the correct one.

You can look in the "compatible" property of the root node in /proc/device-tree

That will have the exact string used to match the platform.

	Arnd
