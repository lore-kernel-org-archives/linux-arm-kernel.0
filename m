From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2018 10:03:17 +0100
Subject: [PATCH] ARM: dts: aspeed: Add default memory node
In-Reply-To: <20180314071312.17492-1-joel@jms.id.au>
References: <20180314071312.17492-1-joel@jms.id.au>
Message-ID: <CAK8P3a3XTqFHw4SQMt9zq3QLEhGM6944xQ_n3myOK08YZCbkAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 8:13 AM, Joel Stanley <joel@jms.id.au> wrote:
> When we removed the inclusion of skeleton.dtsi from the device trees, we
> broke booting for systems with bootloaders that aren't device tre aware.
> This can be seen, for example, when appending the device tree blob to
> the kernel image.
>
> The reason booting broke was that the kernel lacked the device_type
> label in the memory node. Add in a default memory node wth the
> device_type. It can contain the memory address as the location is fixed
> for each SoC generation, but the size needs to be added by the
> bootloader or the board specific dts.
>
> Fixes: 73102d6fdc32 ("ARM: dts: aspeed: Remove skeleton.dtsi")
> Cc: <stable@vger.kernel.org>
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Arnd, can you please merge this as a fix for 4.16?

Sure, applied to fixes branch now.

     Arnd
