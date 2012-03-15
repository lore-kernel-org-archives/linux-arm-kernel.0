From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Mar 2012 17:54:43 +0000
Subject: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
In-Reply-To: <201203151746.56678.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <4F622884.6060807@linaro.org> <20120315173714.GF15988@n2100.arm.linux.org.uk>
 <201203151746.56678.arnd@arndb.de>
Message-ID: <20120315175443.GG15988@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 05:46:56PM +0000, Arnd Bergmann wrote:
> Can you elaborate? I suggested the split in order to keep the ux500
> specific parts local to one file. With the device tree conversion,
> we really want to have them out of the platform code, but sticking them
> into the main driver seems wrong, too.

You're talking about the data structures which describe what quirks to
apply for the ux500 parts, rather than the actual quirks themselves.
That's not a particularly clever thing to do because it separates out
the selection of the works from the rest of the driver, which means
simply searching for the flags to find out what's applied for what has
to span several files.
