From: joe@perches.com (Joe Perches)
Date: Tue, 28 Oct 2014 20:06:14 -0700
Subject: [PATCH] 6fire: Convert byte_rev_table uses to bitrev8
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E010D1825C@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
 <1414392371.8884.2.camel@perches.com>
 <1414531369.10912.14.camel@perches.com>
 <35FD53F367049845BC99AC72306C23D103E010D1825C@CNBJMBX05.corpusers.net>
Message-ID: <1414551974.10912.16.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-10-29 at 10:42 +0800, Wang, Yalin wrote:
> > Use the inline function instead of directly indexing the array.
> > This allows some architectures with hardware instructions for bit reversals
> > to eliminate the array.
[]
> > On Sun, 2014-10-26 at 23:46 -0700, Joe Perches wrote:
> > > On Mon, 2014-10-27 at 14:37 +0800, Wang, Yalin wrote:
> > > > this change add CONFIG_HAVE_ARCH_BITREVERSE config option, so that
> > > > we can use arm/arm64 rbit instruction to do bitrev operation by
> > > > hardware.
[]
> I think the most safe way is change byte_rev_table[] to be satic,
> So that no driver can access it directly,
> The build error can remind the developer if they use byte_rev_table[]
> Directly .

You can do that with your later patch, but the
existing uses _must_ be converted first so you
don't break the build.
