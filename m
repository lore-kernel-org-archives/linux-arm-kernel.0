From: greg@kroah.com (Greg KH)
Date: Wed, 12 Sep 2018 21:38:16 +0200
Subject: [stable PATCH 1/2] arm64: Fix mismatched cache line size detection
In-Reply-To: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
References: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180912193816.GF21563@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 10:10:09AM +0100, Suzuki K Poulose wrote:
> commit 4c4a39dd5fe2d13e2d2fa5fceb8ef95d19fc389a upstream
> 
> If there is a mismatch in the I/D min line size, we must
> always use the system wide safe value both in applications
> and in the kernel, while performing cache operations. However,
> we have been checking more bits than just the min line sizes,
> which triggers false negatives. We may need to trap the user
> accesses in such cases, but not necessarily patch the kernel.
> 
> This patch fixes the check to do the right thing as advertised.
> A new capability will be added to check mismatches in other
> fields and ensure we trap the CTR accesses.
> 
> Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
> Cc: <stable@vger.kernel.org> # v4.9

Why 4.9?  be68a8aaf925 only showed up in 4.16 and was backported only to
4.14-stable.  Not to 4.9-stable from what I can tell.

thanks,

greg k-h
