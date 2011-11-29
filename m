From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Nov 2011 19:09:43 +0000
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <4ED21E4E.5090004@cam.ac.uk>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
 <201111251602.35227.arnd@arndb.de> <4ED21E4E.5090004@cam.ac.uk>
Message-ID: <201111291909.43833.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 November 2011, Jonathan Cameron wrote:

> > As indicated by Shawn, adding a new driver specific kernel-level ADC
> > interface is not a good idea. IIRC, the result of the last discussion
> > was that all ADC drivers should be part of IIO and you should use
> > the IIO in-kernel interfaces. Not sure what the state of that code
> > is, but if it's not in mainline yet, you should work with Jonathan
> > to make sure it gets there. Having more users for that code can
> > only speed up the process, and I'm going to refuse another ADC driver
> > in drivers/misc or arch/arm/mach-*/.
> 
> Quick summary of IIO status.  Nothing is in mainline yet.  Intent is to
> get the first set of core code (including in kernel pull interfaces)
> into linux-next fairly shortly (these have had enough postive feedback
> now I think).  Doing push interfaces (as I think we would need here) is
> possible with existing patches on top of the stuff in the iio staging
> tree but there are some 'interesting' cases where both push and pull
> interfaces exist that still need addressing.
> 
> Also, note the push interface stuff (e.g. interrupt driven) requires a
> lot more of the IIO infrastructure to be in place (buffered support and
> the demux unit) so may still be some time.  Personally my time is
> currently very restricted so all the help anyone can offer is most welcome!

Ok, thanks for the summary!

Peter, I guess what this means for you is that it's best to first
get your code working with the IIO/ADC stuff that is in staging,
and get the touchscreen driver ready for merging, on top of that.

Ideally, you would also help out a bit on getting the IIO parts
you need graduated from staging. Given Jonathan's explanation,
I think my initial reaction was valid: we shouldn't take the
ADC driver outside of IIO, because that ends up being more painful
than getting the driver ready for inclusion now, and then rewriting
it shortly after.

	Arnd
