From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 Jun 2012 10:03:09 -0600
Subject: [PATCH] printk: Fix alignment of buf causing crash on ARM EABI
In-Reply-To: <1338879154-6546-1-git-send-email-andrew@lunn.ch>
References: <1338879154-6546-1-git-send-email-andrew@lunn.ch>
Message-ID: <4FCE2DBD.9030609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2012 12:52 AM, Andrew Lunn wrote:
> Commit 7ff9554bb578ba02166071d2d487b7fc7d860d62, printk: convert
> byte-buffer to variable-length record buffer, causes systems using
> EABI to crash very early in the boot cycle. The first entry in struct
> log is a u64, which for EABI must be 8 byte aligned.
> 
> Make use of __alignof__() so the compiler to decide the alignment, but
> allow it to be overridden using CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
> for systems which can perform unaligned access and want to save
> a few bytes of space.
> 
> Tested on Orion5x and Kirkwood.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Tested-by: Stephen Warren <swarren@wwwdotorg.org>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Indeed, using alignof is a good idea.
