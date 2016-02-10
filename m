From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 09:28:23 +0000
Subject: [PATCH] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <1455046156-10582-1-git-send-email-ddaney.cavm@gmail.com>
References: <1455046156-10582-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160210092822.GA1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 11:29:16AM -0800, David Daney wrote:
> From: Andrew Pinski <apinski@cavium.com>
> 
> On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
> instructions may cause the icache to become invalid if it contains
> data for a non-current ASID.
> 
> This patch implements the workaround (which flushes the local icache
> when switching the mm) by using code patching.

So, to be clear, is this "just" a performance problem as opposed to a
correctness issue? If so, do you have any numbers with and without this
change?

Will
