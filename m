From: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 28 Jan 2013 22:18:04 -0800
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <alpine.LFD.2.02.1301282320430.6300@xanadu.home>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
 <alpine.LFD.2.02.1301282320430.6300@xanadu.home>
Message-ID: <bce35b9a-0b62-4655-ad5e-972e2bd51a95@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uhm... you're saying we have to be at one extreme or the other?

We probably could drop the legacy lzma format, but someone might rely on it.

Nicolas Pitre <nico@fluxnic.net> wrote:

>On Mon, 28 Jan 2013, Andrew Morton wrote:
>
>> On Sat, 26 Jan 2013 14:50:43 +0900
>> Kyungsik Lee <kyungsik.lee@lge.com> wrote:
>> 
>> > This patchset is for supporting LZ4 compressed kernel and initial
>ramdisk on
>> > the x86 and ARM architectures.
>> > 
>> > According to http://code.google.com/p/lz4/, LZ4 is a very fast
>lossless
>> > compression algorithm and also features an extremely fast decoder.
>> > 
>> > Kernel Decompression APIs are based on implementation by Yann
>Collet
>> > (http://code.google.com/p/lz4/source/checkout).
>> > De/compression Tools are also provided from the site above.
>> > 
>> > The initial test result on ARM(v7) based board shows that the size
>of kernel
>> > with LZ4 compressed is 8% bigger than LZO compressed  but the
>decompressing
>> > speed is faster(especially under the enabled unaligned memory
>access).
>> > 
>> > Test: 3.4 based kernel built with many modules
>> > Uncompressed kernel size: 13MB
>> > lzo: 6.3MB, 301ms
>> > lz4: 6.8MB, 251ms(167ms, with enabled unaligned memory access)
>> > 
>> > It seems that it___s worth trying LZ4 compressed kernel image or
>ramdisk 
>> > for making the kernel boot more faster.
>> >
>> > ...
>> >
>> >  20 files changed, 663 insertions(+), 3 deletions(-)
>> >
>> > ...
>> >
>> 
>> What's this "with enabled unaligned memory access" thing?  You mean
>"if
>> the arch supports CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS"?  If so,
>> that's only x86, which isn't really in the target market for this
>> patch, yes?
>
>I'm guessing this is referring to commit 5010192d5a.
>
>> It's a lot of code for a 50ms boot-time improvement.  Does anyone
>have
>> any opinions on whether or not the benefits are worth the cost?
>
>Well, we used to have only one compressed format.  Now we have nearly 
>half a dozen, with the same worthiness issue between themselves.  
>Either we keep it very simple, or we make it very flexible.  The former
>
>would argue in favor of removing some of the existing formats, the
>later 
>would let this new format in.
>
>
>Nicolas

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
