From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 25 Aug 2016 20:34:44 +0200
Subject: [PATCH v2] arm: KVM: Fix idmap overlap detection when the kernel
 is idmap'ed
In-Reply-To: <1471852877-17197-1-git-send-email-marc.zyngier@arm.com>
References: <1471852877-17197-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160825183444.GA13095@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 09:01:17AM +0100, Marc Zyngier wrote:
> We're trying hard to detect when the HYP idmap overlaps with the
> HYP va, as it makes the teardown of a cpu dangerous. But there is
> one case where an overlap is completely safe, which is when the
> whole of the kernel is idmap'ed, which is likely to happen on 32bit
> when RAM is at 0x8000000 and we're using a 2G/2G VA split.
> 
> In that case, we can proceed safely.
> 
> Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks, applied.

-Christoffer
