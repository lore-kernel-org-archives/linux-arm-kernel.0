From: nkela@cisco.com (Nikunj Kela (nkela))
Date: Thu, 5 Jul 2018 23:40:39 +0000
Subject: [PATCH 2/2] arm64: add support for 43bit physical address
In-Reply-To: <20180705183452.vaaxjsrus6lnqyzt@armageddon.cambridge.arm.com>
References: <20180702210451.16057-2-nkela@cisco.com>
 <20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
 <1530642932209.57184@cisco.com>
 <20180705183452.vaaxjsrus6lnqyzt@armageddon.cambridge.arm.com>
Message-ID: <9FA2F50C-F4C8-460C-B6BF-B9DF38C95111@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I didn?t try FLATMEM. Thanks for advising, I enabled FLATMEM for ARM64 and am able to save ~14M. Will post a new patch for Kconfig changes.

Thanks,
-Nikunj

On 7/5/18, 11:35 AM, "Catalin Marinas" <catalin.marinas@arm.com> wrote:

    On Tue, Jul 03, 2018 at 06:35:32PM +0000, Nikunj Kela (nkela) wrote:
    > We are trying to reduce the memory allocation needed for kdump kernel.
    > We want to reserve less than 32M for kdump kernel if possible. We are
    > able to get ~14M saving by the proposed change.
    
    Have you tried disabling SPARSEMEM and using FLATMEM for this case? With
    32M you wouldn't need more than a section anyway. It needs some tweaking
    of the arm64 Kconfig and probably fail to build.
    
    -- 
    Catalin
    
