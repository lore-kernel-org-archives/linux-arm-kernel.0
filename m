From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 18 Jul 2016 18:23:06 +0200
Subject: [PATCH] ARM: dma-mapping: Use %zu for printing a size_t variable
In-Reply-To: <CAOMZO5BqMfyDnJqHXPgH4LepDhJ13=rumXrvQUjswMZVBbLtow@mail.gmail.com>
References: <1468714210-1407-1-git-send-email-festevam@gmail.com>
 <7fe0460e-3455-cb37-c961-ca44841abdcb@gmail.com>
 <CAOMZO5BqMfyDnJqHXPgH4LepDhJ13=rumXrvQUjswMZVBbLtow@mail.gmail.com>
Message-ID: <597a1eda-5792-c7a5-eadd-c9ee82c73f47@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/18/2016 06:11 PM, Fabio Estevam wrote:
> On Mon, Jul 18, 2016 at 1:03 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>
>> size_t should be formated as %zu or %zx so %zx is fine here.
>
> We are printing memory size here, so we should better print it in
> decimal instead of hex.
>
> For example: let's suppose we want to print that 256kiB allocation failed.
>
> If we use %zu:
> DMA: failed to allocate 256KiB pool for atomic coherent allocation
>
> If we use %zx:
> DMA: failed to allocate 100KiB pool for atomic coherent allocation
>
> ,which is not really what we want.
>

Fair enough, didn't realize that.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
