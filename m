From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 13 Nov 2009 15:03:35 +0800
Subject: [PATCH] pxa: make index mfp unsigned in mfp_read() and write()
In-Reply-To: <4AFAE0DA.6040300@gmail.com>
References: <4AFAE0DA.6040300@gmail.com>
Message-ID: <f17812d70911122303x53892464le04883069ad99e64@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 12:05 AM, Roel Kluin <roel.kluin@gmail.com> wrote:
> When signed, it is possible in theory to pass a negative mfp,
> and read/write outside the array bounds.
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> ?arch/arm/plat-pxa/include/plat/mfp.h | ? ?4 ++--
> ?arch/arm/plat-pxa/mfp.c ? ? ? ? ? ? ?| ? ?4 ++--
> ?2 files changed, 4 insertions(+), 4 deletions(-)
>
> I did not observe the passing of a negative mfp anywhere so this
> can be considered as a cleanup. Alternatively I could introduce
> a `mfp < 0' check in mfp_{read,write} instead if desired.
>

I'd prefer to have a check in mfp_{read,write} instead.
