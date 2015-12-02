From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 14:46:32 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20151202103522.GB21461@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1712431.VUth4NvudT@wuerfel> <20151202103522.GB21461@yury-N73SV>
Message-ID: <2623148.F7bGmbuQQh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 13:35:22 Yury Norov wrote:
> On Wed, Dec 02, 2015 at 09:37:05AM +0100, Arnd Bergmann wrote:
> > The 4*PAGE_SIZE on ARM is an architecture specific oddity, I believe
> > to work around aliasing caches on ARMv6. As no other architecture does
> > this, we're probably better off not duplicating it for aarch64-ilp32
> > and just use sys_shmat as your v6 patch does.
> >       Arnd
> 
> If you feel ARMv6 fix for caches will come soon, just ignore it.
> Otherwise, please pull it because compat_sys_shmat is broken now
> for 64K pages.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 

Sounds good. Will, do you want to take this for the arm64 tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
