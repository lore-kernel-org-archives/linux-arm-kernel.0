From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 May 2013 15:59:27 +0100
Subject: [RFC PATCH v2 10/11] ARM64: mm: Raise MAX_ORDER for 64KB pages
 and THP.
In-Reply-To: <1368006763-30774-11-git-send-email-steve.capper@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-11-git-send-email-steve.capper@linaro.org>
Message-ID: <20130516145927.GF18308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 10:52:42AM +0100, Steve Capper wrote:
> The buddy allocator has a default MAX_ORDER of 11, which is too
> low to allocate enough memory for 512MB Transparent HugePages if
> our base page size is 64KB.
> 
> This patch introduces MAX_ZONE_ORDER and sets it to 14 when 64KB
> pages are used in conjuction with THP, otherwise the default value
> of 11 is used.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
