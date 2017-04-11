From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 12 Apr 2017 09:14:07 +1000
Subject: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
In-Reply-To: <20170411143138.GC6821@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
 <1491917983.7236.9.camel@kernel.crashing.org>
 <20170411143138.GC6821@red-moon>
Message-ID: <1491952447.7236.24.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-11 at 15:31 +0100, Lorenzo Pieralisi wrote:
> > This is a semantic that simply *cannot* be generically provided accross
> > architectures as a mapping attribute.
> 
> I agree that a default implementation does not make much sense. The
> only solution to this, if we want the ioremap_nopost to be made available
> to generic code (and drivers - ie DT PCI host bridge drivers on ARM/ARM64
> are not arch code), is to make the ioremap_nopost() call return NULL
> unless overriden by arch code that can provide its semantics.

That would be a better option.

You might be able to implement a fallback, for example by having the
config ops do a read back from the bridge.

Ben.
