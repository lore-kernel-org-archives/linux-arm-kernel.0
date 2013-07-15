From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Jul 2013 15:08:25 +0100
Subject: [PATCH] ARM: a.out: remove partial a.out support
In-Reply-To: <1373894897-30607-1-git-send-email-will.deacon@arm.com>
References: <1373894897-30607-1-git-send-email-will.deacon@arm.com>
Message-ID: <20130715140825.GU24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 02:28:17PM +0100, Will Deacon wrote:
>  arch/arm/include/uapi/asm/Kbuild  |  1 -
>  arch/arm/include/uapi/asm/a.out.h | 34 -----------------------------

I don't think we can remove this quite as easily as this - this is
a user visible API change as it's part of the userland headers, and
will break anything in userspace which includes <a.out.h>
