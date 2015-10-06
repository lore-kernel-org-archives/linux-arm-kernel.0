From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Oct 2015 20:28:36 +0100
Subject: [PATCH] ARM:mm: fix kmap_atomic_to_page
In-Reply-To: <1444129773-12632-1-git-send-email-chanho.min@lge.com>
References: <1444129773-12632-1-git-send-email-chanho.min@lge.com>
Message-ID: <20151006192836.GX21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 08:09:33PM +0900, Chanho Min wrote:
> Since kmap_atomic returns the pkmap address without a new mapping to
> fixmap for the page that is already mapped by kmap, It should be
> considered for the pkmap address in kmap_atomic_to_page.

What's the reasoning behind this change, given that I can find lots of
definitions of kmap_atomic_to_page() in the kernel, but not a single
user of this.

If there's no users, should we be deleting this code?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
