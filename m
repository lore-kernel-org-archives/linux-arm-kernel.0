From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 22 Feb 2013 10:43:47 -0700
Subject: [U-Boot] [RFC] Kbuild support for ARM FIT images
In-Reply-To: <CA+T6QP=gHtOuZbjsbv5_GswZu7FUXW+9KVw6K06+5X_PNzqODw@mail.gmail.com>
References: <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
 <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
 <20130221211444.GB20114@obsidianresearch.com>
 <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
 <20130221231848.880DE200552@gemini.denx.de>
 <20130221232821.GA2823@obsidianresearch.com>
 <5126B979.5000205@gmail.com>
 <20130222022212.GB11169@obsidianresearch.com>
 <CA+T6QP=gHtOuZbjsbv5_GswZu7FUXW+9KVw6K06+5X_PNzqODw@mail.gmail.com>
Message-ID: <20130222174347.GA10206@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 02:56:33AM -0500, Jason Kridner wrote:
> >> The desired FPGA use case is DT updates after booting the kernel. This
> >> has nothing to do with FIT images. And if the FPGA tools generate the
> >> DTB, then it is certainly not tied to the kernel.
> >
> > Completely unrelated, but do you have any pointer for how to do this?
> > Hot plugging a 'dtb fragment' into the kernel would be really handy..
> 
> This doesn't answer the full question on how FPGA tools generate DTB,
> but it is a huge problem for BeagleBone add-on hardware that we have

In all my cases I hand code the DT's for the FPGA IP, they get quite
big, the one I'm looking at now has over 17 DT nodes inside the FPGA
already. This is why we are re-using the DT framework to describe the
chip, not building a C coded PCI driver to do the same work.

> some mechanism to dynamically load DT fragments. Pantelis posted some
> work in that direction[1] and has continued development of his patches
> and we've been using those extensively with BeagleBone kernel
> development[2].

Yes, I saw this. They look really interesting, I think the notion of
hot plugging a DT fragment into the main DT is useful for many
applications..

Jason
