From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 23 Oct 2009 05:33:27 +0800
Subject: [PATCH] Zaurus: Fix PROM partition table for spitz
In-Reply-To: <1256246014.9561.24.camel@utx.utx.cz>
References: <1256245103.9561.11.camel@utx.utx.cz>
	<f17812d70910221405v753eadbdu67c0d532ac77e222@mail.gmail.com>
	<1256246014.9561.24.camel@utx.utx.cz>
Message-ID: <f17812d70910221433x27998c6do4617d2b259d6ef90@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 5:13 AM, Stanislav Brabec <utx@penguin.cz> wrote:
> Eric Miao wrote:
>> I'm a bit upset that some things else may depend on the original
>> layout (though that's incorrect), and this possibly breaks the
>> sequence numbering of /dev/mtd?.
>
> It can break in many ways, e. g. by compiling one as module and another
> into kernel, and depends on order of modules load.
>
> That is why software should search partitions by name.
>

But there might be software that doesn't. I'd be a little bit
conservative about this.

> AFAIK, nothing uses the EN-JP or initial bootloader data in the 2.6.x
> distros, so it should be just safe housekeeping.
>

This, on the other hand, says it's also safe not to inserting
some additional partition in between :-)

(I won't refuse some comments to make this more clear in the code
though).
