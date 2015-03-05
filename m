From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Mar 2015 09:55:15 -0800
Subject: [PATCH v9 01/21] ACPI / table: Use pr_debug() instead of
 pr_info() for MADT table scanning
In-Reply-To: <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150305175515.GA4932@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 04:39:41PM +0800, Hanjun Guo wrote:
> For a normal 8 cpu sockets system, it will up to 240 cpu threads (Xeon E7
> v2 family for now), and we need 240 entries for local apic or local x2apic
> in MADT table, so it will be much verbose information printed with a slow
> uart console when system booted, this will be even worse with large system
> with 16/32 cpu sockets.
> 
> This patch just use pr_debug() instead of pr_info() for ioapic/iosapic,
> local apic/x2apic/sapic structures when scanning the MADT table to remove
> those verbose information, but leave other structures unchanged.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>

(This can surely go in now and not be pending on the rest of the patch set)


-Olof
