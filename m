From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:26:29 +0800
Subject: [RFC 33/34] dmaengine: PL08x: get rid of write only pool_ctr and
 free_txd locking
In-Reply-To: <E1SZJ0P-000713-Ii@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZJ0P-000713-Ii@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZ8SUW6oZC5s3PzmQQ=bGQaK2LdM95S4CQss=n6mY3k-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:46 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> The free function says the pl08x lock should be taken before calling
> it. ?However, the DMA pool allocation/freeing is already properly
> locked. ?The only thing that would need this is pool_ctr, which
> happens to be a write-only variable.
>
> Let's get rid of this, and eliminate any need for additional locking
> here.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
