From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jul 2018 19:34:53 +0100
Subject: [PATCH 2/2] arm64: add support for 43bit physical address
In-Reply-To: <1530642932209.57184@cisco.com>
References: <20180702210451.16057-2-nkela@cisco.com>
 <20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
 <1530642932209.57184@cisco.com>
Message-ID: <20180705183452.vaaxjsrus6lnqyzt@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 06:35:32PM +0000, Nikunj Kela (nkela) wrote:
> We are trying to reduce the memory allocation needed for kdump kernel.
> We want to reserve less than 32M for kdump kernel if possible. We are
> able to get ~14M saving by the proposed change.

Have you tried disabling SPARSEMEM and using FLATMEM for this case? With
32M you wouldn't need more than a section anyway. It needs some tweaking
of the arm64 Kconfig and probably fail to build.

-- 
Catalin
