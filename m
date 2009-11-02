From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 2 Nov 2009 11:42:25 +0800
Subject: Why flush_cache_all() not including flushing L2 cache if the
	system has L2 cache?
In-Reply-To: <4AEE44AD.4010604@gmail.com>
References: <4AEE44AD.4010604@gmail.com>
Message-ID: <f17812d70911011942vbf43be3wb32455ae54fe1ef3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 2, 2009 at 10:32 AM, Peter Chen <hzpeterchen@gmail.com> wrote:
> Dear list,
>
> I met a problem if the address is first used by cachable, then uncachable.
> After that, the address will be filled with cachable value
> after that L2 cache line is evicted.
>

L2 cache is usually physically tagged, and from the CPU POV, it's
consistent once the L1 is flushed.

If you have problems with L2 not being flushed, it's most likely a
device issue, which means you probably need the dma_ API.
