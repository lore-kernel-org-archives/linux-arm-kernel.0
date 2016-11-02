From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Nov 2016 21:03:32 +0000
Subject: [PATCH] arm64: errata: Check for --fix-cortex-a53-843419 and
 --fix-cortex-a53
In-Reply-To: <20161031194414.61287-1-code@mmayer.net>
References: <20161031194414.61287-1-code@mmayer.net>
Message-ID: <20161102210331.GJ22791@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 12:44:14PM -0700, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> The new errata check leads to a warning with some older versions of the
> linker that do know how to work around the errata, but still use the
> original name of the command line option: --fix-cortex-a53. The commit
> in question that changed the name of the option can be found at [1].
> It looks like only "gold" is affected by this rename. Traditional "ld"
> isn't. (There, the argument was always called --fix-cortex-a53-843419.)
> 
> To allow older versions of gold to properly handle the erratum if they
> can, check whether ld supports the old name of this option in addition
> to checking the new one.
> 
> [1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=7a2a1c793578a8468604e661dda025ecb8d0bd20;hp=cfbf0e3c5b637d66b2b1aeadecae9c187b825b2f
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

If newer versions of gold accept the correct option name, why do we care?

Will
