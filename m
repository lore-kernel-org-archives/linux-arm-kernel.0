From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Dec 2010 19:05:03 +0000
Subject: [PATCH 4/4] Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <AANLkTim1Wspod2LnfVw7atzP921C6o7EiKRVqw9LeqhG@mail.gmail.com>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-5-git-send-email-john.stultz@linaro.org>
	<20101214093002.GA18425@n2100.arm.linux.org.uk>
	<AANLkTim1Wspod2LnfVw7atzP921C6o7EiKRVqw9LeqhG@mail.gmail.com>
Message-ID: <20101214190503.GB24303@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 05:51:36PM +0000, Catalin Marinas wrote:
> But what's the problem if such mapping disappears? The
> flush_cache_user_range code should just skip such pages.

That's only half the story.

What if someone remaps something over that range before the cache
maintainence has completed.
