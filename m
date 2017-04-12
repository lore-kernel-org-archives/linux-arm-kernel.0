From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Apr 2017 16:55:49 -0300
Subject: [PATCH -next] imx7: fix Kconfig warning and build errors
In-Reply-To: <8f538f2f-320a-78bb-1008-8e27908f8cf9@infradead.org>
References: <47fc2167-bf0a-866a-e075-8247a10aa6e0@infradead.org>
 <CAOMZO5CF4GZx2UWxq3SF_=g9hnSS9A28T4tPLaSHQr-qJs623Q@mail.gmail.com>
 <8f538f2f-320a-78bb-1008-8e27908f8cf9@infradead.org>
Message-ID: <CAOMZO5BNzJjuvzRyhBO-aB857eW1GzcP0XAy0Y9Hgkfqcc3wgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 4:24 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

> You want IMX7_PM_DOMAINS to be built without having
> PM_GENERIC_DOMAINS enabled?
>
> On x86, your suggestion works for me... because of this
> in drivers/soc/Makefile:
>
> obj-$(CONFIG_ARCH_MXC)          += imx/
>
> and I don't have CONFIG_ARCH_MXC, so the gpc* binaries are
> not being built at all.  This might be a small bug.

Just tested your patch with imx_v6_v7_defconfig + manually doing
CONFIG_PM=n  and it does fix the build error, thanks:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
