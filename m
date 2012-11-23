From: viresh.kumar@linaro.org (viresh kumar)
Date: Fri, 23 Nov 2012 21:23:31 +0530
Subject: [PATCH 3/8] pl080.h: moved from arm/include/asm/hardware to
 include/linux/amba/
In-Reply-To: <1353683310-23654-4-git-send-email-ciminaghi@gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-4-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CAOh2x=keCbnPQzxB+AT5hEt_ukQ6GhPLuxkaQJCML27H9LbWwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 8:38 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> From: Alessandro Rubini <rubini@gnudd.com>
>
> The header is used by drivers/dma/amba-pl08x.c, which can be compiled
> under x86, where PL080 exists under a PCI-to-AMBA bridge. This patche
> moves it where it can be accessed by other architectures, and fixes
> all users.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> ---
>  arch/arm/include/asm/hardware/pl080.h |  146 ---------------------------------
>  arch/arm/mach-s3c64xx/dma.c           |    2 +-
>  arch/arm/mach-spear3xx/spear3xx.c     |    2 +-
>  arch/arm/mach-spear6xx/spear6xx.c     |    2 +-
>  drivers/dma/amba-pl08x.c              |    2 +-
>  include/linux/amba/pl080.h            |  146 +++++++++++++++++++++++++++++++++
>  6 files changed, 150 insertions(+), 150 deletions(-)
>  delete mode 100644 arch/arm/include/asm/hardware/pl080.h
>  create mode 100644 include/linux/amba/pl080.h

Again, generating this patch with

git format-patch -C -M would have given us an easier patch to review.

--
viresh
