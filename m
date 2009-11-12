From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Thu, 12 Nov 2009 13:06:44 +0200
Subject: Submitting patches for new LPC313x machine support
In-Reply-To: <A2403073D589354FB342892C1CB8F90607DC7C8FA7@EU1RDCRDC1WX029.exi.nxp.com>
References: <A2403073D589354FB342892C1CB8F90607DC7C8FA7@EU1RDCRDC1WX029.exi.nxp.com>
Message-ID: <4AFBEC44.2050309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2009 04:10 AM, Durgesh Pattamatta wrote:
> Hi All,

[...]

> We have used 'mach-lh7a40x' as an example in accessing registers. But other mach- use
> readl()/writel() routines to access chip registers. Is 'mach-lh7a40x' technique acceptable?

Please use readl()/writel() or even __raw_readl()/__raw_writel()
depending on how bus endianess is/isn't changed.

'mach-lh7a40x' technique hides important details about atomicity of
these register manipulations.

> Regards,
> Durgesh
