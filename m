From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Jan 2014 13:45:50 +0000
Subject: [PATCH v6 0/3] AArch64: KGDB support
In-Reply-To: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20140116134550.GA7496@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:50:48AM +0000, vijay.kilari at gmail.com wrote:
> Vijaya Kumar K (3):
>   AArch64: KGDB: Add Basic KGDB support
>   AArch64: KGDB: Add step debugging support
>   KGDB: make kgdb_breakpoint() as noinline

I gave them a try and now I have some doubts about your testing
methodology:

1. There is no HAVE_ARCH_KGDB anywhere in these patches, so
the code here isn't compiled.

2. There are several compiler warnings that need to be addressed.

3. I enabled CONFIG_KGDB_TESTS and CONFIG_KGDB_TESTS_ON_BOOT and that's
what really scared me.

Please address these before we can consider the patches for merging.

-- 
Catalin
