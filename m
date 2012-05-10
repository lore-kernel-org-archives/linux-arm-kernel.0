From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 May 2012 14:43:42 +0100
Subject: [PATCH 1/7] mmc: dw_mmc: lookup for optional biu and ciu clocks
In-Reply-To: <CAAG0J9-NDM9wLKpq04ofPkvFqiWxjmP84ojsP9Hfs0SJ_0FaXg@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-2-git-send-email-thomas.abraham@linaro.org>
 <CAAG0J9-NDM9wLKpq04ofPkvFqiWxjmP84ojsP9Hfs0SJ_0FaXg@mail.gmail.com>
Message-ID: <20120510134342.GA12727@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 03:53:53PM +0100, James Hogan wrote:
> Hi
> 
> On 2 May 2012 06:07, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> > + ? ? ? if (IS_ERR(host->biu_clk))
> > + ? ? ? ? ? ? ? dev_info(&host->dev, "biu clock not available\n");
> 
> In this case, should it set host->biu_clk to NULL or are clk_disable
> and clk_put guaranteed to handle an IS_ERR value?

I keep saying this.  NULL must be treated as a valid reutrn value from
clk_get() and must not use this as a sentinel.  The clk namespace is
that errors are indicated with IS_ERR(clk) returning true.  Everything
else must be assumed to be valid by drivers.
