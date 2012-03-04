From: B04825@freescale.com (Tabi Timur-B04825)
Date: Sun, 4 Mar 2012 23:32:50 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120304232817.GA13516@n2100.arm.linux.org.uk>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
 <20120304232817.GA13516@n2100.arm.linux.org.uk>
Message-ID: <4F53FBA1.8090200@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> Is the SCR shared between capture and playback?  In that case, what
> makes this read-modify-write thread safe?

What's "SCR"?

It's not thread-safe on PPC, but then neither is the entire function.  You 
can't have two threads attempt to initialize the hardware at the same 
time.  The macro does not attempt to be atomic, just convenient.

-- 
Timur Tabi
Linux kernel developer at Freescale
