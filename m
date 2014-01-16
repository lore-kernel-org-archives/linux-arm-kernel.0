From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jan 2014 00:35:42 +0000
Subject: [PATCH v3 4/6] arm: add early_ioremap support
In-Reply-To: <52D72883.3020500@codeaurora.org>
References: <1389325833-16535-1-git-send-email-msalter@redhat.com>
 <1389325833-16535-5-git-send-email-msalter@redhat.com>
 <52D72883.3020500@codeaurora.org>
Message-ID: <20140116003542.GS15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 04:32:03PM -0800, Laura Abbott wrote:
> Neither x86 nor arm64 get rid of existing mapping in paging_init. Is  
> there a reason this needs to be here for arm? Are there concerns about  
> alias mappings?

The early mappings we setup in the assembly code are imperfect - they're
an approximation.  We map just about enough memory to get the kernel
going, and we setup a mapping for the debug stuff using a section
mapping, which may not be appropriate.

The permissions too are a just chosen to get things going, and the
subsequent replacement of the page table entries is to fix all that up.
We really don't want any old entries left behind.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
