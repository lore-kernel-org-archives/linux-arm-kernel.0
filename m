From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Dec 2015 23:06:58 +0100
Subject: [RFC PATCH 2/5] crypto: sunxi-ss: fix min3() call to match types
In-Reply-To: <1450787267-26836-3-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-3-git-send-email-andre.przywara@arm.com>
Message-ID: <201512222306.58681.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 December 2015, Andre Przywara wrote:
> The min3() macro expects all arguments to be of the same type (or
> size at least). While two arguments are ints or u32s, one is size_t,
> which does not match on 64-bit architectures.
> Cast the size_t to u32 to make min3() happy. In this context here the
> length should never exceed 32 bits anyway.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Looks correct, but a bit ugly. Could we avoid the casts by using
temporary variables to keep the size_t based data?

	Arnd
