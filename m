From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jun 2014 18:18:38 +0100
Subject: [PATCHv2 3/4] arm64: cachetype: report weakest cache policy
In-Reply-To: <1403024674-25108-4-git-send-email-mark.rutland@arm.com>
References: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
 <1403024674-25108-4-git-send-email-mark.rutland@arm.com>
Message-ID: <20140618171838.GG17851@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 06:04:33PM +0100, Mark Rutland wrote:
> In big.LITTLE systems, the I-cache policy may differ across CPUs, and
> thus we must always meet the most stringent maintenance requirements of
> any I-cache in the system when performing maintenance to ensure
> correctness. Unfortunately this requirement is not met as we always look
> at the current CPU's cache type register to determine the maintenance
> requirements.
> 
> This patch causes the I-cache policy of all CPUs to be taken into
> account for icache_is_aliasing and icache_is_aivivt. If any I-cache in
> the system is aliasing or AIVIVT, the respective function will return
> true. At boot each CPU may set flags to identify that at least one
> I-cache in the system is aliasing and/or AIVIVT.
> 
> The now unused and potentially misleading icache_policy function is
> removed.

Ah, ok, you're growing cpuinfo.c. Ignore my earlier comment about deleting
the header then :)

Will
