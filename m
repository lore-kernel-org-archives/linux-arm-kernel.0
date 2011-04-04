From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 4 Apr 2011 14:27:45 +0100
Subject: [PATCH 4/4] Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <AANLkTimw839TCrzY0X4n8_AcwwdT1kFxNQNNsFC9SRdb@mail.gmail.com>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-5-git-send-email-john.stultz@linaro.org>
	<20101214093002.GA18425@n2100.arm.linux.org.uk>
	<AANLkTim1Wspod2LnfVw7atzP921C6o7EiKRVqw9LeqhG@mail.gmail.com>
	<20101214190503.GB24303@n2100.arm.linux.org.uk>
	<AANLkTimw839TCrzY0X4n8_AcwwdT1kFxNQNNsFC9SRdb@mail.gmail.com>
Message-ID: <BANLkTinmCNi3MgcZo5CJorpoLNxwMwhVOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 14 December 2010 21:08, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tuesday, 14 December 2010, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Tue, Dec 14, 2010 at 05:51:36PM +0000, Catalin Marinas wrote:
>>> But what's the problem if such mapping disappears? The
>>> flush_cache_user_range code should just skip such pages.
>>
>> That's only half the story.
>>
>> What if someone remaps something over that range before the cache
>> maintainence has completed.
>
> That someone remapping the same range can only be a thread of the same
> process. If the code was so badly written as to unmap ranges of memory
> when a thread actively uses it, then it probably deserves any
> corruption.

I haven't seen any more replies in this thread but I still think it's
a real problem as John reported. Do you agree with the original patch?
That's the original post if you no longer have it in your inbox:

http://article.gmane.org/gmane.linux.ports.arm.kernel/99356

-- 
Catalin
