From: msalter@redhat.com (Mark Salter)
Date: Wed, 05 Feb 2014 10:04:15 -0500
Subject: [PATCH] arm64: fix early_io_map for 64K pages
In-Reply-To: <1391611829-7824-1-git-send-email-robherring2@gmail.com>
References: <1391611829-7824-1-git-send-email-robherring2@gmail.com>
Message-ID: <1391612655.18760.25.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-02-05 at 08:50 -0600, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> earlyprintk is broken with 64KB pages. The problem is pgprot_default
> is not yet initialized when early_io_map is called, so the pte does not
> get marked as valid. Set the necessary page and access permission bits.
> 
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> 

FWIW, I had a patch in my early_ioremap series which initialized
pgprot_default earlier in boot:

http://www.spinics.net/lists/arm-kernel/msg299656.html

(which reminds me to get v4 of that series out this week)
