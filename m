From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Sep 2013 15:06:32 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130901123433.GR6617@n2100.arm.linux.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
Message-ID: <20130902140632.GQ3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 01:34:33PM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 01, 2013 at 01:19:28PM +0100, Mark Brown wrote:

> > We do appear to have a fairly good success rate with systems working
> > with mainline; I can only think of one driver that didn't make it in and
> > that was one where we had a bit of an issue getting the code to visually
> > resemble Linux code so I don't feel too bad about it.  I am aware of
> > some people who didn't work upstream, we've generally had some useful
> > discussions with them once we've found each other.

> I wonder whether you include my ASoC sa11x0 assabet driver in that,
> which I gave up trying to get into mainline, because it didn't fit
> ASoC with its requirement to have the SSP transmit DMA running in
> order to capture, and didn't use the latest soc-dmaengine stuff.
> That driver remains in my tree, and is continually forward-ported,
> and built in my nightly ARM builds.

To be honest not really, you've only mentioned it by providing links to
the git repository (it's never been posted) and there has been no real
discussion of the issues or other interest in getting the code
integrated.  For the capture DMA requirement you mention I'd expect a
driver local fix should be OK so long as it's well abstracted - it's not
likely to be a common issue.  

The approach I think I have suggested before is to get playback only
support merged then worry about dealing with the fun stuff needed for
capture support, that still seems like the most obvious way forwards if
there is a desire to get the code merged.

> > While it is correct that I have been saying the final result should use
> > DPCM (since this is what the hardware looks like) you will recall that I
> > did recently suggest either/or as a stepping stone towards a full
> > implementation, allowing systems with only S/PDIF to be supported while
> > the other issues are still being worked on.

> Yes, and when I asked for details how you'd like that done, you
> conveniently decided that you would not reply to that.

Indeed.  This was due to the way you asked:

   http://thread.gmane.org/gmane.linux.ports.arm.kernel/257542/focus=111909

which didn't indicate a great deal of interest in pursing this,
suggesting that it wasn't worth the effort going into more detail.
Something more like "that sounds like a useful idea, I've looked but I'm
not quite sure how to implement it" would have done so.

> This is where those who are using mainline kernels with DT on Dove
> platforms (like Jean-Francois and Sebastian) need a working solution to
> this in a form which they can come up with a representative DT solution.
> This is not a one-person effort - there's multiple efforts working on
> this, and it's all inter-linked.

Yes, and this is one of the reasons for suggesting getting either/or
support merged - it will help things like the binding definition
progress (as well as being useful for any users with a S/PDIF only
system).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130902/51e92dd1/attachment.sig>
