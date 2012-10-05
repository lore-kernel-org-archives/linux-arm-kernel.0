From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2012 10:00:25 +0100
Subject: [PATCH 14/15] KVM: ARM: Handle I/O aborts
In-Reply-To: <20121001125326.GA2100@linaro.org>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153559.21241.29970.stgit@ubuntu>
 <20120927151108.GM25916@mudshark.cambridge.arm.com>
 <CANM98qKFKU98EWNaOepjxab3h5vQypxdt_YoJbKV9kd31XUfaw@mail.gmail.com>
 <20121001125326.GA2100@linaro.org>
Message-ID: <20121005090025.GK4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 01:53:26PM +0100, Dave Martin wrote:
> A good starting point would be load/store emulation as this seems to be a
> common theme, and we would need a credible deployment for any new
> framework so that we know it's fit for purpose.

Probably not actually, that code is written to be fast, because things
like IP stack throughput depend on it - particularly when your network
card can only DMA packets to 32-bit aligned addresses (resulting in
virtually all network data being misaligned.)
