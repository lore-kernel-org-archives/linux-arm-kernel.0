From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 Aug 2010 10:20:11 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <AANLkTinPaq+0MbdW81uoc5_OZ=1Gy_mVYEBnwv8zgOBd@mail.gmail.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100825173125.0855a6b0@bike.lwn.net>
	<AANLkTinPaq+0MbdW81uoc5_OZ=1Gy_mVYEBnwv8zgOBd@mail.gmail.com>
Message-ID: <1282810811.1975.246.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-08-26 at 11:49 +0900, Minchan Kim wrote:
> But one of
> problems is anonymous page which can be has a role of pinned page in
> non-swapsystem. 

Well, compaction can move those around, but if you've got too many of
them its a simple matter of over-commit and for that we've got the
OOM-killer ;-)
