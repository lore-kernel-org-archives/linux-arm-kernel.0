From: jcm@redhat.com (Jon Masters)
Date: Tue, 4 Sep 2018 14:38:02 -0400
Subject: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <3dd55e21-7424-071a-0f7e-d24fc2396f2a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2018 11:52 AM, Will Deacon wrote:

> I hacked up this RFC on the back of the recent changes to the mmu_gather
> stuff in mainline. It's had a bit of testing and it looks pretty good so
> far.

I will request the server folks go and test this. You'll probably
remember a couple of parts we've seen where aggressive walker caches
ended up (correctly) seeing stale page table entries and we had all
manner of horrifically hard to debug problems. We have some fairly nice
reproducers that were able to find this last time that we can test.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
