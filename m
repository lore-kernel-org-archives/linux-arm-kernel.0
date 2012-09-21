From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Sep 2012 09:48:07 +0100
Subject: [PATCH 1/4] ARM: mm: use pteval_t to represent page protection
 values
In-Reply-To: <1348156605-30398-2-git-send-email-will.deacon@arm.com>
References: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
 <1348156605-30398-2-git-send-email-will.deacon@arm.com>
Message-ID: <20120921084806.GC21464@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 04:56:42PM +0100, Will Deacon wrote:
> When updating the page protection map after calculating the user_pgprot
> value, the base protection map is temporarily stored in an unsigned long
> type, causing truncation of the protection bits when LPAE is enabled.
> This effectively means that calls to mprotect() will corrupt the upper
> page attributes, clearing the XN bit unconditionally.
> 
> This patch uses pteval_t to store the intermediate protection values,
> preserving the upper bits for 64-bit descriptors.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
