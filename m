From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jul 2016 13:11:03 -0300
Subject: [PATCH] ARM: dma-mapping: Use %zu for printing a size_t variable
In-Reply-To: <7fe0460e-3455-cb37-c961-ca44841abdcb@gmail.com>
References: <1468714210-1407-1-git-send-email-festevam@gmail.com>
 <7fe0460e-3455-cb37-c961-ca44841abdcb@gmail.com>
Message-ID: <CAOMZO5BqMfyDnJqHXPgH4LepDhJ13=rumXrvQUjswMZVBbLtow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 1:03 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:

> size_t should be formated as %zu or %zx so %zx is fine here.

We are printing memory size here, so we should better print it in
decimal instead of hex.

For example: let's suppose we want to print that 256kiB allocation failed.

If we use %zu:
DMA: failed to allocate 256KiB pool for atomic coherent allocation

If we use %zx:
DMA: failed to allocate 100KiB pool for atomic coherent allocation

,which is not really what we want.
