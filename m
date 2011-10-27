From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Oct 2011 09:33:18 +0100
Subject: [PATCH v4] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <1319703535.20054.30.camel@vkoul-udesk3>
References: <1318907324-17046-1-git-send-email-Barry.Song@csr.com>
	<1319703535.20054.30.camel@vkoul-udesk3>
Message-ID: <20111027083318.GC19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 01:48:55PM +0530, Vinod Koul wrote:
> On Mon, 2011-10-17 at 20:08 -0700, Barry Song wrote:
> > From: Rongjun Ying <Rongjun.Ying@csr.com>
> > 
> > Cc: Jassi Brar <jaswinder.singh@linaro.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > ---
> >  -v4:
> >  add error handler in probe;
> >  free resource in remove;
> >  add necessary comments in source codes;
> >  fix the mismatch of license between file head and MODULE_LINCENSE;
> >  define MACRO to replace magic number for xlen/dma_width boundary.
> Barry,
> 
> You should _always_ run checkpatch before sending patches. It should
> have 0 errors.

Not true.

> ERROR: trailing whitespace
> #773: FILE: drivers/dma/sirf-dma.c:649:
> +^I$
> 
> 
> Also there are bunch of 80char warning, see if you can reduce/eliminate
> them without sacrificing the code readability, and looking at them it
> seems possible

80char warnings about printks should be ignored, because breaking kernel
messages across lines prevents them from being greppable.  This (breaking
kernel messages, particularly error messages, across multiple lines) is a
topic Linus has frequently complained about.
