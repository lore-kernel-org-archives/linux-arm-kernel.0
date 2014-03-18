From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Mar 2014 16:01:47 +0100
Subject: [PATCH] ARM: cache-tauros2: remove ARMv6 code
In-Reply-To: <CAN1soZz6-+s4bKbCJFXQResa07Ub9s1qfRrf2nDLC8eFVQEDsg@mail.gmail.com>
References: <1589565.fmu2VlFkhj@wuerfel>
 <CAN1soZz6-+s4bKbCJFXQResa07Ub9s1qfRrf2nDLC8eFVQEDsg@mail.gmail.com>
Message-ID: <201403181601.48227.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 March 2014, Haojian Zhuang wrote:
> On Wed, Mar 12, 2014 at 2:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > When building a kernel with support for both ARMv6 and ARMv7 but
> > no MMU, the call from tauros2_internal_init to adjust_cr causes
> > a link error. While that could probably be resolved, we don't
> > actually support cache-tauros2 on ARMv6 any more. All PJ4 CPU
> > implementations support both ARMv6 and ARMv7 and we already assume
> > that we are using them only in ARMv7 mode.
> >
> > Removing the ARMv6 code path reduces the code size and avoids
> > the linker error.
>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Thanks!

Russell, do you want to add this patch to your l2x0 series, or
should I put it into the patch tracker by itself?

	Arnd
