From: joe@perches.com (Joe Perches)
Date: Wed, 27 Feb 2013 09:39:47 -0800
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <alpine.LFD.2.03.1302271211360.1254@syhkavp.arg>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
 <alpine.LFD.2.03.1302261557220.1254@syhkavp.arg>
 <87fw0i7n6d.fsf@dell.be.48ers.dk>
 <20130226221027.GW17833@n2100.arm.linux.org.uk>
 <1361929234.1924.8.camel@joe-AO722>
 <20130227095609.GY17833@n2100.arm.linux.org.uk>
 <1361980152.2035.13.camel@joe-AO722>
 <20130227163118.GB17833@n2100.arm.linux.org.uk>
 <1361984688.2035.20.camel@joe-AO722>
 <alpine.LFD.2.03.1302271211360.1254@syhkavp.arg>
Message-ID: <1361986787.20540.8.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-02-27 at 12:16 -0500, Nicolas Pitre wrote:
> On Wed, 27 Feb 2013, Joe Perches wrote:
> > On Wed, 2013-02-27 at 16:31 +0000, Russell King - ARM Linux wrote:
> > > On Wed, Feb 27, 2013 at 07:49:12AM -0800, Joe Perches wrote:
> > > > On Wed, 2013-02-27 at 09:56 +0000, Russell King - ARM Linux wrote:
> > > > > On Tue, Feb 26, 2013 at 05:40:34PM -0800, Joe Perches wrote:
> > > > > > On Tue, 2013-02-26 at 22:10 +0000, Russell King - ARM Linux wrote:
> > > > > > > So... for a selected kernel version of a particular size, can we please
> > > > > > > have a comparison between the new LZO code and this LZ4 code, so that
> > > > > > > we can see whether it's worth updating the LZO code or replacing the
> > > > > > > LZO code with LZ4?
> > > > > > 
> > > > > > How could it be questionable that it's worth updating the LZO code?
> > > > > 
> > > > > Please read the comments against the previous posting of these patches
> > > > > where I first stated this argument - and with agreement from those
> > > > > following the thread.  The thread started on 26 Jan 2013.  Thanks.
> > > > 
> > > > https://lkml.org/lkml/2013/1/29/145
> > > > 
> > > > I did not and do not see significant value in
> > > > adding LZ4 given Markus' LZO improvements.
> > > 
> > > Sorry, a 66% increase in decompression speed over the updated LZO code
> > > isn't "significant value" ?
> > 
> > We disagree.
> > 
> > > I'm curious - what in your mind qualifies "significant value" ?
> > 
> > faster boot time. smaller, faster overall code.
> 
> Sorry, but you certainly successfully got me confused, and probably 
> others as well.
> 
> RMK says that "66% increase in decompression speed over LZO" is 
> significant.  You apparently disagree with that.

Yeah, I can see how that can be interpreted.
I'm referring only to the new LZO.

I guess Russell has not reviewed the new LZO.

There is apparently no speed increase for LZ4 over
the new LZO.

I believe Markus has shown comparison testing in
this very thread.

https://patchwork.kernel.org/patch/2187441/

> Then you say that faster boot time is significant.

Increasing speed in incumbent code without adding
defects is always useful no?.  Replacing incumbent
code with new code should be debated for utility.

I still think there's not much value in adding LZ4.
LZ4 is not not faster than LZO, it's just more code.
