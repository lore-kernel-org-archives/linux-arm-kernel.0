From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Sep 2016 11:14:07 +0100
Subject: next-20160909 build: 1 failures 0 warnings (next-20160909)
In-Reply-To: <E1biHa1-0004JG-Om@optimist>
References: <E1biHa1-0004JG-Om@optimist>
Message-ID: <20160909101407.GA27946@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 09:54:37AM +0100, Build bot for Mark Brown wrote:

Since yesterday -next has been failing to build an arm64 allmodconfig
due to:

> 	arm64-allmodconfig
> ERROR: "memblock_is_memory" [drivers/hwmon/xgene-hwmon.ko] undefined!

caused by 05dbf57876b97d2 (hwmon: Add xgene hwmon driver).  That symbol
is not exported so can't be used from modules though I can't immediately
see how that module acquired a reference to that symbol.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/1803546f/attachment.sig>
