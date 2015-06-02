From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Jun 2015 00:40:48 +0100
Subject: [PATCH v2 1/2] ARM: Add cpu_resume_arm() for firmwares that
 resume in ARM state
In-Reply-To: <1433272378-8470-2-git-send-email-sboyd@codeaurora.org>
References: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
 <1433272378-8470-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150602234048.GA7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 12:12:57PM -0700, Stephen Boyd wrote:
> Some platforms always enter the kernel in the ARM state even if
> the kernel is compiled for THUMB2. Add a small wrapper on top of
> cpu_resume() that switches into THUMB2 state.
> 
> This fixes a problem reported by Kevin Hilman on next-20150601
> where the ifc6410 fails to boot a THUMB2 kernel because the
> platform's firmware always enters the kernel in ARM mode from
> deep idle states.

I think this bit of the commit message isn't quite correct: this will
only resolve the boot problem with a T2 kernel when the failing platform
is converted to use the cpu_resume_arm() entry point.

Apart from that, the patch looks good to me, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
