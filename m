From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 13:23:50 -0800
Subject: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions"
 node
In-Reply-To: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20151222212350.GF30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 21, 2015 at 11:33:44AM +0100, Geert Uytterhoeven wrote:
> 	Hi,
> 
> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> property to "partitions" node"), which is in v4.4-rc6, the "partitions"
> subnode of an SPI FLASH device node must have a compatible property. The
> partitions are no longer detected if it is not present.
> 
> However, several DTSes in -next have already been converted to the
> "partitions" subnode without "compatible" property, introduced by
> commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
> partitions in a special 'partitions' subnode"). Hence all of these are
> now broken in -next, and will be broken in upstream during the merge
> window.

So, if I understand this correctly, the partitions format was added for v4.4,
then this non-backwards compatible change was added in -rc6. But, there were
also DT files that had the new-for-v4.4 partitions nodes in them that then
stopped working in -rc6?

That sounds like a regression, so this should be picked up as fixes for v4.4.

Please confirm that I've understood the setup correctly, and I'll apply the
series directly to fixes.


-Olof
