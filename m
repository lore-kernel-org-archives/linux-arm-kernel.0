From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Sep 2012 22:59:58 +0100
Subject: [PATCH 2/8] gpio: pl061 depends on ARM
In-Reply-To: <1347639843-32119-3-git-send-email-dciminaghi@mail.gnudd.com>
References: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
 <1347639843-32119-3-git-send-email-dciminaghi@mail.gnudd.com>
Message-ID: <20120917215958.GT12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 06:23:57PM +0200, Davide Ciminaghi wrote:
> From: Alessandro Rubini <rubini@gnudd.com>
> 
> Patch dece904d itroduced chained_irq_enter/exit, which is only
> available for arch/arm and the driver won't compile elsewhere.
> 
> The dependency is thus made explicit, because AMBA is used in the x86
> world by a PCI-to-AMBA bridge, to be submitted.
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

The real solution to this is to stop the madness that chained_irq_enter/
chained_irq_exit are both ARM-only.
