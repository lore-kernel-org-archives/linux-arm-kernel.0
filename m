From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2010 09:11:11 +0000
Subject: large page support for IOP331
In-Reply-To: <9ff69a5d1002240100r708381ceha1ca29f2bd6f18b@mail.gmail.com>
References: <9ff69a5d1002240100r708381ceha1ca29f2bd6f18b@mail.gmail.com>
Message-ID: <20100224091111.GA7598@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 02:30:30PM +0530, Prashant Bhole wrote:
> Is there any support of large page for arm architecture?

The short answer is no.

The long answer is that to have 16K pages, it causes bigger problems
with the 2nd level page tables, which from the hardware perspective
are only 256 per L1 entry, but are required to be in unique pages.
