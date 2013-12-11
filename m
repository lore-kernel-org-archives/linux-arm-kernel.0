From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 11 Dec 2013 14:00:52 -0500
Subject: [PATCH 6/8] add support to supplement atags to device tree
In-Reply-To: <1386767259-15693-7-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <1386767259-15693-7-git-send-email-p.wilczek@samsung.com>
Message-ID: <20131211190052.GD10053@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Piotr,

First, thanks for the patch series!

On Wed, Dec 11, 2013 at 02:07:37PM +0100, Piotr Wilczek wrote:
> Signed-off-by: Piotr Wilczek <p.wilczek@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  Makefile          |    9 +-
>  atags.h           |    2 +
>  atags_to_fdt.c    |  197 +++++++
>  fdt.c             |  224 ++++++++
>  fdt_ro.c          |  576 +++++++++++++++++++++
>  fdt_rw.c          |  494 ++++++++++++++++++
>  fdt_wip.c         |  120 +++++
>  libfdt.h          | 1478 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  libfdt_env.h      |   13 +
>  libfdt_internal.h |   95 ++++
>  main.c            |    4 +
>  setup.h           |  187 +++++++
>  types.h           |   28 +
>  13 files changed, 3426 insertions(+), 1 deletion(-)
>  create mode 100644 atags_to_fdt.c
>  create mode 100644 fdt.c
>  create mode 100644 fdt_ro.c
>  create mode 100644 fdt_rw.c
>  create mode 100644 fdt_wip.c
>  create mode 100644 libfdt.h
>  create mode 100644 libfdt_env.h
>  create mode 100644 libfdt_internal.h
>  create mode 100644 setup.h

I was actually working on this, but you beat me to it :)

Could you copy the libfdt directory out of dtc and use it as is?
That'll make upgrading in the future easier. iow, place these files in
libfdt/.


thx,

Jason.
