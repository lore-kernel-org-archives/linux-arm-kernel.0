From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 14 Jun 2012 12:33:01 +0100
Subject: [PATCH 0/2] ARM: vexpress: Enable SPARSE_IRQ selection
In-Reply-To: <20120614085553.GB28714@n2100.arm.linux.org.uk>
References: <1339607602-3846-1-git-send-email-tixy@linaro.org>
 <20120614085553.GB28714@n2100.arm.linux.org.uk>
Message-ID: <1339673581.3044.10.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-14 at 09:55 +0100, Russell King - ARM Linux wrote:
> So you're relying on the GIC IRQs starting at 0, and so that the local
> timer interrupt stays at 29 ?

Well, the existing code already did that ;-)

>   And the local timer interrupt is now
> just some random number buried in some C file.

Yes, that did leave a bit of a bad taste, I guess in the back of my mind
I had the (erroneous?) thought that this non-device-tree code would be
going away soon.

However, for the purpose of enabling sparse irqs, we don't actually need
to mess with the IRQ defines so I'll follow up with an alternative patch
which leaves them alone...

-- 
Tixy
