From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 16 Jun 2011 13:09:58 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <1308241030-15201-1-git-send-email-holler@ahsoftware.de>
Message-ID: <Pine.LNX.4.44L0.1106161308310.2204-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jun 2011, Alexander Holler wrote:

> In commit 139540170d9d9b7ead3caaf540f161756b356d56 the attribute
> packed is removed from the structs which are used to access the EHCI-registers.
> 
> This is done to circumvent a problem with gcc 4.6, which might access members of
> packed structs on a byte by byte basis. But using packed, aligned(4) fixes that
> too and is imho the better solution. Otherwise (without packed) the compiler would be free
> to choose whatever alignment he thinks fits best, which might be e.g. 8-byte on 64-bit machines.

Is that really true?  I thought the compiler was not allowed to insert 
padding if the natural alignment of the data types didn't require any.

Alan Stern
