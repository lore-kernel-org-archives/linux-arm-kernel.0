From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Apr 2016 17:38:14 +0100
Subject: [PATCH v7 12/16] arm64: Add new asm macro copy_page
In-Reply-To: <1459529620-22150-13-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-13-git-send-email-james.morse@arm.com>
Message-ID: <20160420163814.GF11377@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 05:53:36PM +0100, James Morse wrote:
> From: Geoff Levand <geoff@infradead.org>
> 
> Kexec and hibernate need to copy pages of memory, but may not have all
> of the kernel mapped, and are unable to call copy_page().
> 
> Add a simplistic copy_page() macro, that can be inlined in these
> situations. lib/copy_page.S provides a bigger better version, but
> uses more registers.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> [Changed asm label to 9998, added commit message]
> Signed-off-by: James Morse <james.morse@arm.com>

Good enough for the brief usage:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Would there be another user of this macro in the future (kexec)?

-- 
Catalin
