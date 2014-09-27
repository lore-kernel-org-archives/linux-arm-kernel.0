From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Sep 2014 10:58:28 -0300
Subject: [PATCH v2 1/3] drivers: of: add return value to
 of_reserved_mem_device_init (fixup)
In-Reply-To: <1411713865-26192-1-git-send-email-m.szyprowski@samsung.com>
References: <1410434561-9294-2-git-send-email-m.szyprowski@samsung.com>
 <1411713865-26192-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAOMZO5Be=E=TNiaKDSfJC3H=yQBTTnGSa7JBJnjVf7PV=vLLWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, Sep 26, 2014 at 3:44 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> This patch adds missing return value to error paths.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

I have also sent a similar fix:
http://www.spinics.net/lists/devicetree/msg51127.html

> ---
>  drivers/of/of_reserved_mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 7e7de03..e975156 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -250,13 +250,13 @@ int of_reserved_mem_device_init(struct device *dev)
>
>         np = of_parse_phandle(dev->of_node, "memory-region", 0);
>         if (!np)
> -               return;
> +               return -ENODEV;
>
>         rmem = __find_rmem(np);
>         of_node_put(np);
>
>         if (!rmem || !rmem->ops || !rmem->ops->device_init)
> -               return;
> +               return -ENIVAL;

ENIVAL does not exist. I guess you meant EINVAL ;-)
