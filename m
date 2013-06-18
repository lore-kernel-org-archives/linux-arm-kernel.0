From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Jun 2013 11:31:51 +0100
Subject: [RFC PATCH 2/2] arm64: KVM: Fix build errors after 32-bit THP
 support
In-Reply-To: <1371521861-372-2-git-send-email-christoffer.dall@linaro.org>
References: <1371521861-372-1-git-send-email-christoffer.dall@linaro.org>
 <1371521861-372-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20130618103151.GH9930@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 03:17:41AM +0100, Christoffer Dall wrote:
> When KVM 32-bit adds THP support the build of KVM/arm64 will break
> because we rename some definition to be more sane and change the
> interface to coherent_icache_guest_page.
> 
> Huge pages are not supported on arm64 and the pgtable predicates will
> always return false, so this shouldn't change any functionality on the
> 64-bit side.

FYI, huge pages will be supported on arm64 starting with 3.11-rc1. Given
that it's -rc6 now, I would suggest you aim the kvm patches at 3.12.

-- 
Catalin
