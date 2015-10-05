From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 5 Oct 2015 17:45:40 +0200
Subject: [RFT - PATCH v2 0/2] KVM/arm64: add fp/simd lazy switch support
In-Reply-To: <1442964843-11953-1-git-send-email-m.smarduch@samsung.com>
References: <1442964843-11953-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <20151005154540.GJ9011@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 04:34:01PM -0700, Mario Smarduch wrote:
> This is a 2nd itteration for arm64, v1 patches were posted by mistake from an 
> older branch which included several bugs. Hopefully didn't waste too much of 
> anyones time.
> 
> This patch series is a followup to the armv7 fp/simd lazy switch
> implementation, uses similar approach and depends on the series - see
> https://lists.cs.columbia.edu/pipermail/kvmarm/2015-September/016516.html
> 
> It's based on earlier arm64 fp/simd optimization work - see
> https://lists.cs.columbia.edu/pipermail/kvmarm/2015-July/015748.html
> 
> And subsequent fixes by Marc and Christoffer at KVM Forum hackathon to handle
> 32-bit guest on 64 bit host (and may require more here) - see
> https://lists.cs.columbia.edu/pipermail/kvmarm/2015-August/016128.html
> 
> This series has be tested with arm64 on arm64 with several FP applications 
> running on host and guest, with substantial decrease on number of 
> fp/simd context switches. From about 30% down to 2% with one guest running.
> 
> At this time I don't have arm32/arm64 working and hoping Christoffer and/or
> Marc (or anyone) can test 32-bit guest/64-bit host.
> 
Did you already have some test infrastructure/applications that I can
reuse for this purpose or do I have to write userspace software?

-Christoffer
