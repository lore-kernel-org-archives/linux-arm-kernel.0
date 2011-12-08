From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 07 Dec 2011 19:00:59 -0500 (EST)
Subject: [GIT PULL] Identity mapping changes for 3.3
In-Reply-To: <20111207221610.GF14542@n2100.arm.linux.org.uk>
References: <20111202160833.GK5540@mudshark.cambridge.arm.com>
 <20111205232342.GG14542@n2100.arm.linux.org.uk>
 <20111206101438.GB25782@mudshark.cambridge.arm.com>
 <20111206103843.GM14542@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1112062321070.2907@xanadu.home>
 <20111207194826.GB14542@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1112071454100.2907@xanadu.home>
 <20111207221610.GF14542@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1112071844590.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Dec 2011, Russell King - ARM Linux wrote:

> On Wed, Dec 07, 2011 at 03:38:31PM -0500, Nicolas Pitre wrote:
> > Most likely, yes.  The disk throughput shouldn't be such a problem, but 
> > the lack of RAM certainly is.  And 2g of RAM to deal with a repository 
> > the size of the Linux kernel is making it tight.
> 
> So how much RAM is now required - and will be required in the future -
> for running git?  Given that my laptop also has 2G of RAM, it seems
> from what you're saying that's also a problem there - or will be soon.

Well, this depends on what operation you typically use Git for of 
course.  Normally, checkout, commit, log, merge, etc. are operations 
that don't need to walk the entire repository data and are less affected 
by the repository growth than the size of the checked-out tree.

The other class of operations such as fsck, repack, gc, clone, 
push/pull/fetch are likely to see their memory footprint grow with the 
size of the repository.

Fortunately the size of the Linux Git repository tends to grow slower 
than Moore's law.


Nicolas
