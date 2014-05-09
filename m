From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 May 2014 15:44:39 +0100
Subject: [PATCH] ARM: mm: Add workaround for erratum 763126
In-Reply-To: <CAFY15YHPSLMh6iA1PQHjsneL_Kxarc0xL5uJ7_px71cbmJbrgQ@mail.gmail.com>
References: <1399528508-2806-1-git-send-email-arjun.kv@samsung.com>
 <CAD=FV=XeYdgqk3-CpS2NNXFAnn+uGDC6844d-L6vfS=SYEuw-Q@mail.gmail.com>
 <20140508173853.GG8981@arm.com>
 <CAD=FV=X0jQvmA07XZEKT-3FAOaE3p0qCLPUCJKR8Ux1=o46cVQ@mail.gmail.com>
 <20140508180534.GI8981@arm.com>
 <CAFY15YHPSLMh6iA1PQHjsneL_Kxarc0xL5uJ7_px71cbmJbrgQ@mail.gmail.com>
Message-ID: <20140509144439.GG7950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 02:56:02PM +0100, arjun kv wrote:
> As Doug already mentioned, we have not observed an issue which could have been
> triggered by this erratum.
> Nor do we have a method to actually trigger the livelock.
> But if it improves the performance and has no real side effects, we could?at
> least?land this in our local tree?

It's up to you, but do some benchmarks first.

ACTLR bits that improve performance on specific SoCs should really be
set by the firmware before booting the kernel. There is no way for the
kernel to know what works best for your system, especially when we deal
with implementation-defined registers.

-- 
Catalin
