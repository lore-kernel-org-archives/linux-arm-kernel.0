From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 16:18:24 +0100
Subject: [PATCH v3 RESEND 15/17] ARM: mm: use physical addresses in
 highmem sanity checks
In-Reply-To: <1348242975-19184-16-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-16-git-send-email-cyril@ti.com>
Message-ID: <20120924151823.GC14198@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:56:13PM +0100, Cyril Chemparathy wrote:
> This patch modifies the highmem sanity checking code to use physical addresses
> instead.  This change eliminates the wrap-around problems associated with the
> original virtual address based checks, and this simplifies the code a bit.

We need some check here that the upper 32-bit of lowmem addresses are
constant.

-- 
Catalin
