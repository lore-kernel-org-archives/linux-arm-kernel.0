From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Sep 2012 20:13:12 +0100
Subject: [PATCH v2 20/31] arm64: User access library function
In-Reply-To: <201208151449.54834.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-21-git-send-email-catalin.marinas@arm.com>
 <201208151449.54834.arnd@arndb.de>
Message-ID: <20120905191312.GH24085@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 02:49:54PM +0000, Arnd Bergmann wrote:
> It's fairly unusual to have out of line get_user/put_user functions.
> What is the reason for this, other than copying from ARM?

Actually, we never used to out of line on ARM, and then I experimented,
and found there was a net benefit - not only in code size but also
there appeared to be a performance benefit by out of lining them.
