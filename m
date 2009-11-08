From: matthew@wil.cx (Matthew Wilcox)
Date: Sun, 8 Nov 2009 08:23:10 -0700
Subject: [PATCH,RFC] PCI: deal with device incorrectly reporting I/O
	decoding being enabled
In-Reply-To: <20091108090451.GA20529@n2100.arm.linux.org.uk>
References: <20091107135615.GE18639@mail.wantstofly.org>
	<20091107150305.GQ10555@parisc-linux.org>
	<20091108090451.GA20529@n2100.arm.linux.org.uk>
Message-ID: <20091108152310.GA16033@parisc-linux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 08, 2009 at 09:04:51AM +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 07, 2009 at 08:03:05AM -0700, Matthew Wilcox wrote:
> > I'm OK with this ... it might provoke bugs in some _other_ piece of hardware,
> > but that seems pretty unlikely.
> 
> Please remember that some ARM hardware only has the capability to read
> and write full 32-bit quantities of configuration space, which means
> writing the control register can result in the status register being
> written as well.
> 
> That shouldn't be a problem, but is merely something else to consider
> which isn't obvious.

Wow, that's horrid.  You must have to special case each config register
that's accessed in a 16-bit way, since some bits are 'preserve' and others
are 'write 1 to clear'.  What a nightmare.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
