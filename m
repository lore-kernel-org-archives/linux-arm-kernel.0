From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Jul 2016 17:44:31 -0700
Subject: [PATCH v2] ARM: brcmstb: Add earlyprintk support using run-time
 checks
In-Reply-To: <1468281416-14594-1-git-send-email-f.fainelli@gmail.com>
References: <1468281416-14594-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <578EC96F.2030107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2016 04:56 PM, Florian Fainelli wrote:
> The SUN_TOP_CTRL_FAMILY_ID register  is at a fixed absolute address for
> all of our supported chips, so utilize its value to determine what the
> UARTA base address should be based on the value we read.
> 
> Since the code is called both during decompressor when the MMU is off,
> and after the MMU has been turned on in the kernel, and we want to do
> the lookup only once, we use the same technique as tegra.S and have a
> shared storage location between the decompressor and the kernel.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next.
-- 
Florian
