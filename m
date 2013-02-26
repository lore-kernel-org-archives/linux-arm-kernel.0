From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 26 Feb 2013 15:59:56 -0500 (EST)
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <512D1C12.4080109@oberhumer.com>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
Message-ID: <alpine.LFD.2.03.1302261557220.1254@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Feb 2013, Markus F.X.J. Oberhumer wrote:

> On 2013-02-26 07:24, Kyungsik Lee wrote:
> > Hi,
> > 
> > [...]
> > 
> > Through the benchmark, it was found that -Os Compiler flag for
> > decompress.o brought better decompression performance in most of cases
> > (ex, different compiler and hardware spec.) in ARM architecture.
> > 
> > Lastly, CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not always the best
> > option even though it is supported. The decompression speed can be
> > slightly slower in some cases.
> > 
> > This patchset is based on 3.8.
> > 
> > Any comments are appreciated.
> 
> Did you actually *try* the new LZO version and the patch (which is attached
> once again) as explained in https://lkml.org/lkml/2013/2/3/367 ?
> 
> Because the new LZO version is faster than LZ4 in my testing, at least
> when comparing apples with apples and enabling unaligned access in
> BOTH versions:
> 
> armv7 (Cortex-A9), Linaro gcc-4.6 -O3, Silesia test corpus, 256 kB block-size:
> 
>                    compression speed   decompression speed
> 
>   LZO-2012    :          44 MB/sec          117 MB/sec     no unaligned access
>   LZO-2013-UA :          47 MB/sec          167 MB/sec     Unaligned Access
>   LZ4 r88  UA :          46 MB/sec          154 MB/sec     Unaligned Access

To be fair, you should also take into account the compressed size of a 
typical ARM kernel.  Sometimes a slightly slower decompressor may be 
faster overall if the compressed image to work on is smaller.


Nicolas
