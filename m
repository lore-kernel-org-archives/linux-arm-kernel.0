From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 May 2017 10:01:30 +0200
Subject: [PATCH 2/3] asm-generic: don't #include <linux/atomic.h> in
 qspinlock_types.h
In-Reply-To: <20170503145141.4966-3-ynorov@caviumnetworks.com>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <20170503145141.4966-3-ynorov@caviumnetworks.com>
Message-ID: <CAK8P3a01_4mZZbB74hyWO_OXmT-cOd4ezZQoeOA23xh7N-0MFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 4:51 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> The "qspinlock_types.h" doesn't need linux/atomic.h directly. So
> because of this, and because including of it requires the protection
> against recursive inclusion, it looks reasonable to move the
> inclusion exactly where it is needed. This change affects the x86_64
> arch, as the only user of qspinlocks at now. I have build-tested the
> change on x86_64 with CONFIG_PARAVIRT enabled and disabled.
>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Please keep this together with the other patches as they get merged through
the arm64 tree.

       Arnd
