From: shijie8@gmail.com (Huang Shijie)
Date: Wed, 4 Sep 2013 22:04:37 -0400
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <522697E9.1050208@freescale.com>
 <20130904095523.GT3084@sirena.org.uk>
 <52270B8E.5080402@freescale.com>
 <20130904113322.GA5859@sirena.org.uk>
 <20130905014350.GA2261@gmail.com>
 <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
Message-ID: <20130905020435.GA3970@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 01:45:40PM +0000, thomas.langer at lantiq.com wrote:
> Hello Huang,
> 
> >> In what way does the controller driver depend on those changes?
> > This driver needs the spi nor command to fill the LUT register, such as
> > OPCODE_WREN(0x06), so the patch 1 moves the spi nor command to a seprate
> > header spi-nor.h, and this driver includes this new header.
> > 
> Then some questions come up: 
> - Why does the spi controller need to know this?
The hardware works in this way.
> - What is this LUT register at all?
Please see the patch 1.
> - What happens if something different that a flash is connected and 
>    the data starts with one of these opcodes?
Submit a new patch to fix it.


thanks
Huang Shijie
