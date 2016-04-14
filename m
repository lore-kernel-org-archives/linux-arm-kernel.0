From: james.morse@arm.com (James Morse)
Date: Thu, 14 Apr 2016 13:47:28 +0100
Subject: [PATCH v6 14/14] arm64: hibernate: Prevent resume from a different
 kernel version
In-Reply-To: <20160410114938.GB30188@xo-6d-61-c0.localdomain>
References: <1456766423-1554-1-git-send-email-james.morse@arm.com>
 <1456766423-1554-15-git-send-email-james.morse@arm.com>
 <20160410114938.GB30188@xo-6d-61-c0.localdomain>
Message-ID: <570F9160.30408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/16 12:49, Pavel Machek wrote:
> On Mon 2016-02-29 17:20:23, James Morse wrote:
>> Prevent resuming with a different kernel build, by storing UTS_VERSION
>> in the hibernate header. This also ensures the page size and va bits
>> configuration remain the same.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Better solution would be to store the current bits _and_ UTS version. Then bump UTS_VERSION
> every time Linux behaviour changes w.r.t. EFI. For a while, it would change a lot, but then
> it should stabilize, as the port stabilizes

If we want to support resuming with a different kernel version. Patch 13 (of
this series) does this, it has 'HIBERNATE_VERSION', which we would have to
increase every time an incompatible change is made, but I'm worried that its a
constant game of catch-up to work out which changes are compatible. The first
sign a user gets that this isn't supported, (who reads the changelog?), is when
it fails to resume, and they loose any data that was written to the hibernate image.

What does restoring with a different kernel version get used for? (I agree its a
neat trick!) I can see it would be useful on laptops, where the distribution can
upgrade the kernel and the user can still use hibernate before they reboot. But
the distribution can switch this value to be just the kernel version if they are
willing to test hibernate/resume over any updates they make.

If I repost this series, I intend to squash this patch into the main 'add
support for' patch.



Thanks,

James
