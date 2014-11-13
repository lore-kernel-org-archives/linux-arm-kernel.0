From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Nov 2014 15:06:25 +0000
Subject: [PATCH] arm64: __clear_user: handle exceptions on strb
In-Reply-To: <20141112210744.GC6869@redacted.bos.redhat.com>
References: <20141112210744.GC6869@redacted.bos.redhat.com>
Message-ID: <20141113150624.GB18494@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 09:07:44PM +0000, Kyle McMartin wrote:
> ARM64 currently doesn't fix up faults on the single-byte (strb) case of
> __clear_user... which means that we can cause a nasty kernel panic as an
> ordinary user with any multiple PAGE_SIZE+1 read from /dev/zero.
> i.e.: dd if=/dev/zero of=foo ibs=1 count=1 (or ibs=65537, etc.)

Thanks for this, it's been like this for a while. Applied.

-- 
Catalin
