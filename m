From: joe@perches.com (Joe Perches)
Date: Wed, 27 Feb 2013 09:04:48 -0800
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <20130227163118.GB17833@n2100.arm.linux.org.uk>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
 <alpine.LFD.2.03.1302261557220.1254@syhkavp.arg>
 <87fw0i7n6d.fsf@dell.be.48ers.dk>
 <20130226221027.GW17833@n2100.arm.linux.org.uk>
 <1361929234.1924.8.camel@joe-AO722>
 <20130227095609.GY17833@n2100.arm.linux.org.uk>
 <1361980152.2035.13.camel@joe-AO722>
 <20130227163118.GB17833@n2100.arm.linux.org.uk>
Message-ID: <1361984688.2035.20.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-02-27 at 16:31 +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 27, 2013 at 07:49:12AM -0800, Joe Perches wrote:
> > On Wed, 2013-02-27 at 09:56 +0000, Russell King - ARM Linux wrote:
> > > On Tue, Feb 26, 2013 at 05:40:34PM -0800, Joe Perches wrote:
> > > > On Tue, 2013-02-26 at 22:10 +0000, Russell King - ARM Linux wrote:
> > > > > So... for a selected kernel version of a particular size, can we please
> > > > > have a comparison between the new LZO code and this LZ4 code, so that
> > > > > we can see whether it's worth updating the LZO code or replacing the
> > > > > LZO code with LZ4?
> > > > 
> > > > How could it be questionable that it's worth updating the LZO code?
> > > 
> > > Please read the comments against the previous posting of these patches
> > > where I first stated this argument - and with agreement from those
> > > following the thread.  The thread started on 26 Jan 2013.  Thanks.
> > 
> > https://lkml.org/lkml/2013/1/29/145
> > 
> > I did not and do not see significant value in
> > adding LZ4 given Markus' LZO improvements.
> 
> Sorry, a 66% increase in decompression speed over the updated LZO code
> isn't "significant value" ?

We disagree.

> I'm curious - what in your mind qualifies "significant value" ?

faster boot time. smaller, faster overall code.

> Maybe "significant value" is a patch which buggily involves converting
> all those "<n>" printk format strings in assembly files to KERN_* macros,
> thereby breaking those strings because you've not paid attention to what
> .asciz means?  (Yes, I've just cleaned that crap up after you...)

If you mean commit 0cc41e4a21d43, perhaps you could clarify with an
example.  I don't see any relevant changes by you in -next, but
maybe I'm not looking in the right spot.

The change did enable reducing code size.

> > Why would the LZO code not be updated?
> I'm not saying that the LZO code should not be updated.

You said:

> > > > > so that we can see whether it's worth updating the LZO code

Sounded as if you were doubtful to me.

> I'm saying that
> the kernel boot time decompressor is not a play ground for an ever
> increasing number of "my favourite compression method" crap.

Completely agree.
