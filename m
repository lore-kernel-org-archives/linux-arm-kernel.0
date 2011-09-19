From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 14:33:01 +0100
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <4E770FA6.2070305@ti.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
	<CAJuYYwSFu2HC+u2NY41+yw9tEyy85RKa4Dpm3SL+jbwS_OOA0A@mail.gmail.com>
	<4E71CE5D.9030900@ti.com> <4E71F978.6020402@gmail.com>
	<4E72030F.1090300@ti.com> <4E722B2D.4050307@gmail.com>
	<4E770FA6.2070305@ti.com>
Message-ID: <20110919133301.GR16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 11:47:18AM +0200, Cousson, Benoit wrote:
> Since the cpumask is not relevant for the SPI, maybe having two  
> interrupt controllers will be more relevant. Or maybe 3, since there is  
> some SGIs as well.

I don't think anyone uses SGIs outside of the common SMP code.
Therefore they're handled entirely separately for the root GIC.

(If there's two GICs - some platforms do have two - then the SGIs on
the non-root GIC are unused.)
