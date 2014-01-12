From: tj@kernel.org (Tejun Heo)
Date: Sun, 12 Jan 2014 06:49:58 -0500
Subject: [PATCH v8 3/4] ata: Add APM X-Gene SoC SATA host controller driver
In-Reply-To: <6EB44142-06DA-4C9D-8999-CFA9EE30E03D@apm.com>
References: <1389031922-4309-1-git-send-email-lho@apm.com>
 <1389031922-4309-2-git-send-email-lho@apm.com>
 <1389031922-4309-3-git-send-email-lho@apm.com>
 <1389031922-4309-4-git-send-email-lho@apm.com>
 <52D052F9.8050703@redhat.com>
 <20140111193104.GD3257@mtj.dyndns.org>
 <6EB44142-06DA-4C9D-8999-CFA9EE30E03D@apm.com>
Message-ID: <20140112114958.GA8509@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Jan 11, 2014 at 07:58:04PM -0800, Loc Ho wrote:
> The flush has to occurred immediately after reading the CI
> register. It can not wrap around the isr routine and issue the flush
> after or before the library ahci isr routine.

I see.  So, you're saying that if PMP support is disabled for the
controller, the driver would need to reimplement only the interrupt
handler?

thanks.

-- 
tejun
