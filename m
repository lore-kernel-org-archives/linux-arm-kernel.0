From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 04 Jul 2013 14:27:41 -0400 (EDT)
Subject: Appended DTB files for multi-machine kernels
In-Reply-To: <51D5B7A1.60609@gmail.com>
References: <51D5A938.30607@gmail.com>
 <alpine.LFD.2.03.1307041322070.18597@syhkavp.arg> <51D5B7A1.60609@gmail.com>
Message-ID: <alpine.LFD.2.03.1307041419070.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Jul 2013, Daniel Mack wrote:

> Hi Nicolas,
> 
> On 04.07.2013 19:28, Nicolas Pitre wrote:
> > On Thu, 4 Jul 2013, Daniel Mack wrote:
> >> I'm open to opinion and sugesstions :)
> > 
> > What you describe above more or less fits the definition of what I 
> > called the "impedance matcher".  However it doesn't need to be part of 
> > the kernel at all.  But you should make it into a separate binary.
> > 
> > Please have a look at the bottom of this post for a more comprehensive 
> > description: http://article.gmane.org/gmane.linux.ports.arm.kernel/242929
> 
> Thanks for the link. Interesting read indeed.
> 
> The only thing I'm pondering about is that we already have generic
> loader code in Linux and a build system that supports a wide range of
> platforms. I don't know whether it's worth opening that can of worms
> again and re-implement all details about load addresses, compiler flags,
> device-tree parsing code yet once again. At least in terms of LOCs, we
> would certainly be better off doing it inside the kernel.

That is still code with relatively low value that has to be carried and 
maintained.

And if you do it for your own device outside of the kernel then you can 
literally hack it the way you want quickly and forget about it once it 
works.  Since this is useful for legacy setups only, you do not have to 
care about maintaining it in the future.

> But I generally second your opinion about pushing vendors to do it
> right, so I might give that approach a shot soon; there is no code yet
> anywhere I take it?

Not that I'm aware of, besides parts of libfdt and atags_to_fdt.c from 
the kernel tree that can be lifted and modified according to your needs.  
I don't imagine you'd need much more than that anyway.


Nicolas
