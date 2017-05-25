From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 25 May 2017 15:13:07 +0200
Subject: [PATCH v4 6/8] arm,arm64,drivers: reduce scope of
 cap_parsing_failed
In-Reply-To: <20170420144316.15632-7-juri.lelli@arm.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-7-juri.lelli@arm.com>
Message-ID: <20170525131307.GC16244@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 03:43:14PM +0100, Juri Lelli wrote:
> Reduce the scope of cap_parsing_failed (making it static in
> drivers/base/arch_topology.c) by slightly changing {arm,arm64} DT
> parsing code.
> 
> For arm checking for !cap_parsing_failed before calling normalize_
> cpu_capacity() is superfluous, as returning an error from parse_
> cpu_capacity() (above) means cap_from _dt is set to false.
> 
> For arm64 we can simply check if raw_capacity points to something,
> which is not if capacity parsing has failed.
> 
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
