From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Nov 2010 09:38:39 +0000
Subject: [PATCH] ARM: Stop irqsoff tracing if return to user with
	interrupts enabled
In-Reply-To: <20101113084802.GB10125@n2100.arm.linux.org.uk>
References: <1289619648-8690-1-git-send-email-toddpoynor@google.com>
	<20101113084802.GB10125@n2100.arm.linux.org.uk>
Message-ID: <20101113093839.GC10125@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 13, 2010 at 08:48:02AM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 12, 2010 at 07:40:48PM -0800, Todd Poynor wrote:
> > Signed-off-by: Todd Poynor <toddpoynor@google.com>
> 
> NAK.  Firstly, you're not explaining why.  Secondly, we purposely leave
> IRQs off when returning to userspace to avoid race conditions.  Thirdly,
> we purposely leave lockdep believing that IRQs are off while userspace
> is running, even though IRQs are not.

Forthly, we never run userspace with IRQs disabled - that would be a
security hole.

> I've explained why this is in the past - please search the mailing list.

See

http://lists.arm.linux.org.uk/lurker/message/20100523.141301.a94bee0c.en.html
http://lists.arm.linux.org.uk/lurker/message/20100523.194746.203225eb.en.html
