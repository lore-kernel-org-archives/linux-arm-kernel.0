From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Sep 2018 16:44:22 +0100
Subject: [PATCH] arm64: uaccess: implement unsafe accessors
In-Reply-To: <1536232196-55027-1-git-send-email-julien.thierry@arm.com>
References: <1536232196-55027-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20180910154421.zevsqqdxoaislly7@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 12:09:56PM +0100, Julien Thierry wrote:
> Current implementation of get/put_user_unsafe default to get/put_user
> which toggle PAN before each access, despite having been told by the caller
> that multiple accesses to user memory were about to happen.
> 
> Provide implementations for user_access_begin/end to turn PAN off/on and
> implement unsafe accessors that assume PAN was already turned off.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/uaccess.h | 61 ++++++++++++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 15 deletions(-)

Queued for 4.19. Thanks.

-- 
Catalin
