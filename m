From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Feb 2014 14:52:51 +0000
Subject: [PATCH] arm64: fix early_io_map for 64K pages
In-Reply-To: <1391611829-7824-1-git-send-email-robherring2@gmail.com>
References: <1391611829-7824-1-git-send-email-robherring2@gmail.com>
Message-ID: <20140205145250.GC28140@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Feb 05, 2014 at 02:50:29PM +0000, Rob Herring wrote:
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

I thought we fixed this in 4ce00dfcf19c by reverting the use of
pgprot_default?

Will
