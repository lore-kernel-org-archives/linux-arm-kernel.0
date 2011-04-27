From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 09:55:05 +0100
Subject: [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries
	for some global variables
In-Reply-To: <1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110427085505.GM17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 12:15:04AM -0400, Nicolas Pitre wrote:
> Many architecture specific versions of uncompress.h make use of global
> variables marked static.  In such case the GOT is bypassed and the
> code in head.S can't relocate them.

No, we're not doing this - it creates confusion with static variables
declared inside functions.

It's far easier to audit for the presence of 'static' than it is for
the possibility of an ignored 'static' inside a function body.

Ensure that the uncompress.h header files are right.
