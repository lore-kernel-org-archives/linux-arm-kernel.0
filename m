From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 19 May 2010 10:21:41 +1000
Subject: Boot interface for device trees on ARM
In-Reply-To: <AANLkTikg4rQdnbFxBOUkGc_0DrKqRkp9raZ8Ck5xkLG4@mail.gmail.com>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
	<AANLkTikg4rQdnbFxBOUkGc_0DrKqRkp9raZ8Ck5xkLG4@mail.gmail.com>
Message-ID: <20100519002141.GF25892@yookeroo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 10:06:38AM -0400, Jason McMullan wrote:
> With respect to machine IDs, why not have our cake and eat it too?
> 
> (NOTE: This proposal assumes that the boot code has already
>        determined whether ATAGs or a DT has been passed to
>        the kernel, and that ATAG and DT machine IDs are in
>        the same namespace)
> 
> 1) We already have machine names in the mach-types file, and we
> can propose that those are used as the top-level 'compatible'
> tags for the DTs.
> 
> ...
>    compatible = "openrd\000kirkwood\000armv6\000arm"
> ...

That sounds like a good idea.  Except that you should probably prefix
the ARM machine name with something (e.g. "linux,arm-machine-XXXX"),
both to meet the normal OF "vendor,type" convention for compatible
values, and to make sure to avoid any conflicts wth things of other
architectures.

Oh, also, dtc supports nicer syntax for NULL separated stringlists
like that, you can go:
	compatible = "openrd", "kirkwood", "armv6", "arm";

> 2) We can trivially generate a name-to-machine ID hash table from
> the mach-types file (CRC32 of the name, or some other hash)

gperf...

The rest I'm not so sure about, I don't know arch/arm well enough.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
