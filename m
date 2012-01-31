From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Jan 2012 09:29:11 +0000
Subject: [RFC] ARM hugetlb support
In-Reply-To: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
Message-ID: <CAHkRjk6xZy3Nsy=R05664RM0Sw071rkXmV2g9ySwqiS_BrBLrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30 January 2012 07:57,  <bill4carson@gmail.com> wrote:
> This patch aims to support huge page for ARM. For now, 2MB(two 1MB page)/16MB
> huge page are supported, Versatile Express Cortex-A9x4 tile is used as test
> board. Verifications are running with libhugetlbfs and ltp.

I haven't reviewed your patches yet but just a few thoughts. Do you
have a clear case where 16MB super-sections is needed? Do you have
memory beyond 4G that can only be accessed with super-sections? This
is an optional feature and not all processors have it. It also doesn't
help much with the TLB hit rate since the micro-TLB most likely only
support 1MB sections.

BTW, I have a (simpler) implementation of hugetlbfs with 2MB sections
but for LPAE only:

http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-arm-arch.git;a=shortlog;h=refs/heads/hugetlb

-- 
Catalin
