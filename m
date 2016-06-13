From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2016 16:15:17 +0100
Subject: [PATCH 02/10] ARM: V7M: Make read_cpuid() generally available on
 V7M.
In-Reply-To: <1465830189-20128-3-git-send-email-vladimir.murzin@arm.com>
References: <1465830189-20128-1-git-send-email-vladimir.murzin@arm.com>
 <1465830189-20128-3-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160613151517.GV1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 04:03:01PM +0100, Vladimir Murzin wrote:
> This requires a custom specialisation for each of the CPUID_* registers, and
> as more than just CPUID_ID may be implemented in the future this doesn't
> make much sense.

You shouldn't need most of this patch.  The CPUID registers are defined
in such a way that unimplemented registers do not fault, but return the
MIDR value.  If you're just implementing MIDR, then you should just
return the MIDR value and be done with it.

(Any location reading the other CPUID registers without checking whether
it's a MIDR alias is probably buggy.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
