From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Sep 2015 14:42:09 +0100
Subject: [PATCH v2] arm: Fix backtrace generation when IPI is masked
In-Reply-To: <55F819DE.9040704@linaro.org>
References: <1442222294-2756-1-git-send-email-daniel.thompson@linaro.org>
 <1442315112-14039-1-git-send-email-daniel.thompson@linaro.org>
 <20150915113003.GS21084@n2100.arm.linux.org.uk>
 <55F819DE.9040704@linaro.org>
Message-ID: <20150915134208.GT21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 02:15:10PM +0100, Daniel Thompson wrote:
> Actually it already gets masked out. The argument to raise_nmi() points to a
> data structure owned by the backtrace library functions and this structure
> if altered during the execution of nmi_cpu_backtrace() to clear the calling
> CPU.
> 
> I had originally planned to use cpumask_test_and_clear_cpu() for the
> conditional branch but that would be broken because nmi_cpu_backtrace()
> would become a nop if we clear anything from the mask before calling it!
> 
> I guess I should add a comment about this to save us from broken but
> "obviously correct" cleanups in the future...

Absolutely.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
