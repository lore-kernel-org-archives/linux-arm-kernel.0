From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 13 Feb 2014 11:11:55 -0600
Subject: [PATCH 5/5] iommu/arm-smmu: fix compilation issue when
 !CONFIG_ARM_AMBA
In-Reply-To: <20140213170408.GM13576@mudshark.cambridge.arm.com>
References: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
 <1391710173-4343-6-git-send-email-will.deacon@arm.com>
 <CAOZdJXW6tY=MjHGMa1EQtJayY=ToqiJOWsggCsEjfPzirUeUxg@mail.gmail.com>
 <20140213170408.GM13576@mudshark.cambridge.arm.com>
Message-ID: <52FCFCDB.5090907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2014 11:04 AM, Will Deacon wrote:

> It's harmless to enable CONFIG_ARM_AMBA, even if you don't have any AMBA
> devices in your SoC,

Ah, ok.  It's seems obvious now, but somehow that didn't click.

> it just makes your binary a bit bigger because you're
> compiling in code that you don't need. Instead, you might elect to set
> CONFIG_ARM_AMBA=n, at which point the arm-smmu driver will fail to build
> without this patch.

Ok, thanks.  We discovered the same problem internally, and had the same 
solution, but during code reviews some concerns were raised.
