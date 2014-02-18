From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Feb 2014 15:35:52 +0000
Subject: [PATCH] ARM: kernel: improve error message when LPAE config
 doesn't match CPU
In-Reply-To: <1392729618-25094-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392729618-25094-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140218153552.GE21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:20:18PM +0100, Thomas Petazzoni wrote:
> Currently, when the kernel is configured with LPAE support, but the
> CPU doesn't support it, the error message is fairly cryptic:
> 
>   Error: unrecognized/unsupported processor variant (0x561f5811).
> 
> This messages is normally shown when there is an issue when comparing
> the processor ID (CP15 0, c0, c0) with the values/masks described in
> proc-v7.S. However, the same message is displayed when LPAE support is
> enabled in the kernel configuration, but not available in the CPU,
> after looking at ID_MMFR0 (CP15 0, c0, c1, 4). Having the same error
> message is highly misleading.
> 
> This commit improves this by showing a different error message when
> this situation occurs:
> 
>   Error: Kernel with LPAE support, but CPU does not support LPAE.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Nothing obviously wrong, please put it in the patch system, thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
