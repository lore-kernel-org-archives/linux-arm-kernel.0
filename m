From: pawaraj@india.com (Rajesh Pawar)
Date: Tue, 29 Jan 2013 21:09:58 +0000 (UTC)
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <20130128142510.68092e10.akpm@linux-foundation.org>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>,
 <20130128142510.68092e10.akpm@linux-foundation.org>
Message-ID: <254788880.18003.1359493798737.JavaMail.tomcat@be12>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Andrew Morton <akpm@linux-foundation.org> wrote:
>
>On Sat, 26 Jan 2013 14:50:43 +0900
>Kyungsik Lee <kyungsik.lee@lge.com> wrote:
>> This patchset is for supporting LZ4 compressed kernel and initial ramdisk on
>> the x86 and ARM architectures.
>> 
>> According to [[http://code.google.com/p/lz4/,]] LZ4 is a very fast lossless
>> compression algorithm and also features an extremely fast decoder.
>> 
>> Kernel Decompression APIs are based on implementation by Yann Collet
>> ([[http://code.google.com/p/lz4/source/checkout]]).
>> De/compression Tools are also provided from the site above.
>> 
>> The initial test result on ARM(v7) based board shows that the size of kernel
>> with LZ4 compressed is 8% bigger than LZO compressed but the decompressing
>> speed is faster(especially under the enabled unaligned memory access).
>> 
>> Test: 3.4 based kernel built with many modules
>> Uncompressed kernel size: 13MB
>> lzo: 6.3MB, 301ms
>> lz4: 6.8MB, 251ms(167ms, with enabled unaligned memory access)
>> 
>> It seems that it___s worth trying LZ4 compressed kernel image or ramdisk 
>> for making the kernel boot more faster.
>>
>> ...
>>
>> 20 files changed, 663 insertions(+), 3 deletions(-)
>>
>> ...
>>
>What's this "with enabled unaligned memory access" thing? You mean "if
>the arch supports CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS"? If so,
>that's only x86, which isn't really in the target market for this
>patch, yes?
>It's a lot of code for a 50ms boot-time improvement. Does anyone have
>any opinions on whether or not the benefits are worth the cost?

BTW, what happened to the proposed LZO update - woudn't it better to merge this first?

Also, under the hood LZ4 seems to be quite similar to LZO, so probably
LZO speed would also greatly benefit from unaligned access and some other
ARM optimisations
 
