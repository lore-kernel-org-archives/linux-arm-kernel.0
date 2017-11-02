From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 2 Nov 2017 17:47:06 +0100
Subject: [PATCH] arm: ensure dump_instr() checks addr_limit
In-Reply-To: <20171102163452.7652-1-mark.rutland@arm.com>
References: <20171102163452.7652-1-mark.rutland@arm.com>
Message-ID: <20171102164706.GC5061@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 04:34:52PM +0000, Mark Rutland wrote:
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Huh?  What's that doing up here?

> When CONFIG_DEBUG_USER is enabled, it's possible for a user to
> deliberately trigger dump_instr() with a chosen kernel address.
> 
> Let's avoid problems resulting from this by using get_user() rather than
> __get_user(), ensuring that we don't erroneously access kernel memory.
> 
> So that we can use the same code to dump user instructions and kernel
> instructions, the common dumping code is factored out to __dump_instr(),
> with the fs manipulated appropriately in dump_instr() around calls to
> this.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: stable at vger.kernel.org

It's right here...

confused.

greg k-h
