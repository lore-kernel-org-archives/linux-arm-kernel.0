From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2010 22:02:23 +0000
Subject: [PATCH] ARM: Always generate the IT instruction when compiling
	for Thumb-2
In-Reply-To: <20100126101424.14567.70480.stgit@pc1117.cambridge.arm.com>
References: <20100126101424.14567.70480.stgit@pc1117.cambridge.arm.com>
Message-ID: <20100127220223.GC29665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 10:14:24AM +0000, Catalin Marinas wrote:
> Current behaviour is to generate the IT instruction only for Thumb-2
> code. However, the kernel helpers in entry-armv.S are compiled to ARM in
> a unified syntax file (if THUMB2_KERNEL). Recent compilers warn about
> missing IT instruction in unified assembly syntax files. The patch
> changes the "-mimplicit-it" gas option to "always".

Any downsides to this change?  Any assemblers not accepting "always"
instead of "thumb" ?
