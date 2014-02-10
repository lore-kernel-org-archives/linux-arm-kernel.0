From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 15:19:34 +0000
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <20140210144228.GC2794@e103592.cambridge.arm.com>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140207170903.GT5976@mudshark.cambridge.arm.com> <52F892C8.80508@st.com>
 <20140210111710.GC17766@mudshark.cambridge.arm.com>
 <20140210135659.GU26684@n2100.arm.linux.org.uk>
 <20140210144228.GC2794@e103592.cambridge.arm.com>
Message-ID: <20140210151934.GZ26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 02:42:28PM +0000, Dave Martin wrote:
> Should we require CPSR.A to me masked in Booting, for all CPUs that have
> it?

If it's not masked at boot, then there can't be an imprecise exception
pending.

That's unlike interrupts, where a device could trigger an interrupt at
any moment (eg, a timer expiring.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
