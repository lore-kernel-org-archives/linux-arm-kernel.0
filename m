From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Sep 2018 15:01:48 +0100
Subject: [PATCH] arm64: uaccess: implement unsafe accessors
In-Reply-To: <1536232196-55027-1-git-send-email-julien.thierry@arm.com>
References: <1536232196-55027-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20180906140147.GD5212@arm.com>
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

Tested-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
