From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Oct 2010 17:39:58 +0100
Subject: [PATCH] scatterlist: define SG chain for arm architecture
In-Reply-To: <1285950521-8093-1-git-send-email-x0095840@ti.com>
References: <1285950521-8093-1-git-send-email-x0095840@ti.com>
Message-ID: <20101001163958.GA22533@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 01, 2010 at 11:28:41AM -0500, Fernando Guzman Lugo wrote:
> Define SG chain for ARM architecture in order to work
> with big buffers. This patch is needed in order to
> iovmm users can pass a big buffer to map it and ARM
> architecture has not issues using SG chain.
> 
> This change was suggested by FUJITA Tomonori.

Have you audited all places where SG lists are used in the ARM
architecture to ensure that SG chain support is safe?  (That
goes for ARM generic code and ARM specific drivers.)

If the answer is no, this patch is unacceptable until such a
review has been carried out.
