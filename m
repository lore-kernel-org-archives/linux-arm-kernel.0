From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Nov 2009 09:04:51 +0000
Subject: [PATCH,RFC] PCI: deal with device incorrectly reporting I/O
	decoding being enabled
In-Reply-To: <20091107150305.GQ10555@parisc-linux.org>
References: <20091107135615.GE18639@mail.wantstofly.org>
	<20091107150305.GQ10555@parisc-linux.org>
Message-ID: <20091108090451.GA20529@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 07, 2009 at 08:03:05AM -0700, Matthew Wilcox wrote:
> I'm OK with this ... it might provoke bugs in some _other_ piece of hardware,
> but that seems pretty unlikely.

Please remember that some ARM hardware only has the capability to read
and write full 32-bit quantities of configuration space, which means
writing the control register can result in the status register being
written as well.

That shouldn't be a problem, but is merely something else to consider
which isn't obvious.
