From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Sep 2017 11:56:45 -0700
Subject: [PATCH] ARM: brcmstb: Add appropriate ARM_BE8() macros for
 swapping
In-Reply-To: <1504029821-38267-1-git-send-email-f.fainelli@gmail.com>
References: <1504029821-38267-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <81b4ed3d-404c-2dae-6a84-5a891560bafb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2017 11:03 AM, Florian Fainelli wrote:
> Building a big-endian kernel for ARCH_BRCMSTB revealed that we would not
> be correctly polling for the right bit in the busyuart macro, turns out
> there are a few transformations needed to work with big-endian kernels.
> First we need to swap the value we read from SUN_TOP_CTRL to properly
> compare it against our local tables. Then, just like 8250.S we need to
> swap the value before storing it, and conversely swap it after a load.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next.

-- 
Florian
