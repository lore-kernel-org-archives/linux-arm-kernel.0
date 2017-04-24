From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Apr 2017 16:21:06 +0100
Subject: [PATCH 1/2] arm64:vdso: Rewrite gettimeofday into C.
In-Reply-To: <1492991221-5156-1-git-send-email-apinski@cavium.com>
References: <1492991221-5156-1-git-send-email-apinski@cavium.com>
Message-ID: <20170424152106.GG25449@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 23, 2017 at 04:47:00PM -0700, Andrew Pinski wrote:
> This allows the compiler to optimize the divide by 1000.
> And remove the other divide.
> 
> On ThunderX, gettimeofday improves by 32%.  On ThunderX 2,
> gettimeofday improves by 18%.

Is this with or without the second patch (removing the ISB)?

-- 
Catalin
