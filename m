From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jun 2014 10:12:26 +0100
Subject: [PATCH] arm64: mm: Fix horrendous config typo
In-Reply-To: <1403682105-7919-1-git-send-email-steve.capper@linaro.org>
References: <1403682105-7919-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140625091226.GE6153@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 08:41:45AM +0100, Steve Capper wrote:
> The define ARM64_64K_PAGES is tested for rather than
> CONFIG_ARM64_64K_PAGES. Correct that typo here.

Whilst I agree that this is a bad typo, the existing behaviour would
still return false all the time for 64K-page configs, right?

The bigger problem here is testing the hugepage support with all the
wonderful page sizes we've grown. Are there any targetted tests to know
that we're actually exercising 1GB mappings with 4k granules? Certainly,
our stress tests don't appear to be catching this at the moment.

Will
