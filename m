From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 12:13:08 +0000
Subject: [PATCH] ARM: nommu: avoid mapping vectors page when !CONFIG_MMU
In-Reply-To: <1294747337-18238-1-git-send-email-will.deacon@arm.com>
References: <1294747337-18238-1-git-send-email-will.deacon@arm.com>
Message-ID: <20110111121308.GD11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 12:02:17PM +0000, Will Deacon wrote:
> When running without an MMU, we do not need to install a mapping for the
> vectors page. Attempting to do so causes a compile-time error because
> install_special_mapping is not defined.
> 
> This patch adds compile-time guards to the vector mapping functions
> so that we can build nommu configurations once more.

I had a similar patch a few days ago doing the same thing... when Greg's
acked it, please submit to the patch system, thanks.
