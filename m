From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 13:53:01 +0000
Subject: [PATCH v2 07/31] arm64: Process management
In-Reply-To: <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-8-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151353.01367.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +#define THREAD_SIZE_ORDER	1
> +#define THREAD_SIZE		8192
> +#define THREAD_START_SP		(THREAD_SIZE - 16)

THREAD_SIZE_ORDER looks wrong for 64kb-page kernels. It also doesn't seem to
be used, so better remove it.

	Arnd
