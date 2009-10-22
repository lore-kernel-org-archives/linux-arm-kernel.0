From: utx@penguin.cz (Stanislav Brabec)
Date: Thu, 22 Oct 2009 23:13:34 +0200
Subject: [PATCH] Zaurus: Fix PROM partition table for spitz
In-Reply-To: <f17812d70910221405v753eadbdu67c0d532ac77e222@mail.gmail.com>
References: <1256245103.9561.11.camel@utx.utx.cz>
	<f17812d70910221405v753eadbdu67c0d532ac77e222@mail.gmail.com>
Message-ID: <1256246014.9561.24.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> I'm a bit upset that some things else may depend on the original
> layout (though that's incorrect), and this possibly breaks the
> sequence numbering of /dev/mtd?.

It can break in many ways, e. g. by compiling one as module and another
into kernel, and depends on order of modules load.

That is why software should search partitions by name.

AFAIK, nothing uses the EN-JP or initial bootloader data in the 2.6.x
distros, so it should be just safe housekeeping.


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx
