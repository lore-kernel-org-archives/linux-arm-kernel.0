From: andi@firstfloor.org (Andi Kleen)
Date: Thu, 16 Aug 2012 19:52:34 +0200
Subject: [GIT PULL] Update LZO compression
In-Reply-To: <20120816232549.4d14a6aa@natsu>
References: <50299142.2030504@oberhumer.com>
 <20120814123937.GA14756@sig21.net> <502B8FE3.7080501@oberhumer.com>
 <20120815144539.GA8300@sig21.net> <502C92C3.7090701@oberhumer.com>
 <20120816150647.GA22010@sig21.net> <20120816232549.4d14a6aa@natsu>
Message-ID: <20120816175234.GL11413@one.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I have locked the Allwinner A10 CPU in my Mele A2000 to 60 MHz using cpufreq-set,
> and ran your test. rnd.lzo is a 9 MB file from /dev/urandom compressed with lzo.
> There doesn't seem to be a significant difference between all three variants.

I found that in compression benchmarks it depends a lot on the data
compressed.

urandom (which should be essentially incompressible) will be handled
by different code paths in the compressor than other more compressible data.
It becomes a complicated memcpy then.

But then there are IO benchmarks which also only do zeroes, which
also gives an unrealistic picture.

Usually it's best to use some corpus with different data types, from very
compressible to less so; and look at the aggregate.

For my snappy work I usually had at least large executables (medium) and some
pdfs (already compressed; low) and then uncompressed source code tars (high
compression)

-Andi
