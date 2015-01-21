From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 21 Jan 2015 12:08:23 +0100
Subject: [PATCH v16 00/10] KVM/arm/arm64/x86: dirty page logging for
 ARMv7/8 (3.18.0-rc2)
In-Reply-To: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
References: <1421366341-26012-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <20150121110823.GB15076@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 03:58:51PM -0800, Mario Smarduch wrote:
> Patch series adds support for armv7/8 dirty page logging. As we move
> towards generic dirty page logging interface we move some common code to
> generic layer shared by x86, armv7 and armv8.
> 
> armv7/8 Dirty page logging implementation overivew-
> - initially write protects memory region 2nd stage page tables
> - read dirty page log and again write protect dirty pages for next pass.
> - second stage huge pages are dissolved into normal pages to keep track of
>   dirty memory at page granularity. Tracking at huge page granularity
>   limits granularity of marking dirty memory and migration to a light memory
>   load. Small page size logging supports higher memory dirty rates, enables
>   rapid migration.
> 
>   armv7 supports 2MB Huge page, and armv8 supports 2MB (4kb) and
>   512MB (64kb)
> - In the event migration is canceled, normal behavior is resumed huge pages
>   are rebuilt over time.
> 

Thanks, applied.

-Christoffer
