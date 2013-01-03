From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jan 2013 23:11:32 +0000
Subject: [PATCH] arm: Export cache flush management symbols when
 !MULTI_CACHE
In-Reply-To: <1357252353-6200-1-git-send-email-panto@antoniou-consulting.com>
References: <1357252353-6200-1-git-send-email-panto@antoniou-consulting.com>
Message-ID: <20130103231132.GS2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 12:32:33AM +0200, Pantelis Antoniou wrote:
> When compiling a kernel without CONFIG_MULTI_CACHE enabled the
> dma access functions end up not being exported. Fix it.

Actually, that's exactly how these are supposed to be: no driver should
_ever_ reference these symbols directly, they should all be done via
the DMA API, which internally uses these.  Therefore, none of these
should ever appear in a module.
