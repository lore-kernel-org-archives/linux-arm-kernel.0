From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 27 Feb 2013 14:21:54 -0800
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <20130227095139.GX17833@n2100.arm.linux.org.uk>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com> <20130227073646.GA22333@Corona>
 <20130227095139.GX17833@n2100.arm.linux.org.uk>
Message-ID: <20130227142154.f1f40048.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Feb 2013 09:51:39 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Feb 27, 2013 at 04:36:47PM +0900, Kyungsik Lee wrote:
> > Compiler: Linaro ARM gcc 4.6.2
> > 2. ARMv7, 1.7GHz based board
> >    Kernel: linux 3.7
> >    Uncompressed Kernel Size: 14MB
> >          Compressed Size  Decompression Speed
> >     LZO  6.0MB            34.1MB/s            Old
> >          ----------------------------------------
> >          6.0MB            34.7MB/s            New
> >          6.0MB            52.2MB/s(UA)
> >     =============================================
> >     LZ4  6.5MB            86.7MB/s
> > UA: Unaligned memory Access support
> 
> That is pretty conclusive - it shows an 8% increase in image size vs a
> 66% increase in decompression speed.  It will take a _lot_ to offset
> that increase in decompression speed.
> 
> So, what I think is that yes, we should accept LZ4 and drop LZO from
> the kernel - the "fast but may not be small" compression title has
> clearly been taken by LZ4.
> 
> Akpm - what's your thoughts?

It sounds like we should merge both.

I've sent Linus a little reminder for Markus's 3.9 pull request.  Let's
get down and review and test this new code?

David's review comments were useful.

I'd like to also see a Kconfig patch which makes x86 and arm kernels
default to the new LZ4 code.  Then I can sneak that patch into
linux-next so the new code will get some testing.  If we don't do that,
very few people will run it.
