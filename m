From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 18 Dec 2015 16:57:17 +0300
Subject: [PATCH v6 10/20] arm64:ilp32 use the native LP64 'start_thread'
 for ILP32 threads
In-Reply-To: <12007390.0rtOQc0npd@wuerfel>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-11-git-send-email-ynorov@caviumnetworks.com>
 <12007390.0rtOQc0npd@wuerfel>
Message-ID: <20151218135717.GC31200@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 04:50:18PM +0100, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 00:42:36 Yury Norov wrote:
> > +#ifdef CONFIG_ARM64_ILP32
> > +       /* ILP32 threads are started the same way as LP64 threads. */
> > +       if (is_ilp32_compat_task()) {
> > +               start_thread(regs, pc, sp);
> > +               return;
> > +       }
> > +#endif
> > 
> 
> Just a small style comment, but I think you can just leave out the #ifdef,
> as is_ilp32_compat_task() will already return false if that is disabled.
> 
> 	Arnd

Missed it, thank you.
