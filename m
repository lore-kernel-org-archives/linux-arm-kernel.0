From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Aug 2012 17:15:28 +0100
Subject: [PATCH v2 07/31] arm64: Process management
In-Reply-To: <201208151353.01367.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
 <201208151353.01367.arnd@arndb.de>
Message-ID: <20120817161528.GK24389@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 02:53:01PM +0100, Arnd Bergmann wrote:
> On Tuesday 14 August 2012, Catalin Marinas wrote:
> 
> > +#define THREAD_SIZE_ORDER	1
> > +#define THREAD_SIZE		8192
> > +#define THREAD_START_SP		(THREAD_SIZE - 16)
> 
> THREAD_SIZE_ORDER looks wrong for 64kb-page kernels. It also doesn't seem to
> be used, so better remove it.

It's used in kernel/fork.c if THREAD_SIZE >= PAGE_SIZE. I'll define it
conditionally.

-- 
Catalin
