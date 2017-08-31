From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Thu, 31 Aug 2017 10:46:06 +0200
Subject: [RFC PATCH v9 1/7] edac: thunderx: Remove suspend/resume support
In-Reply-To: <20170830175406.ygmathi3b5orzyqy@pd.tnic>
References: <20170829131238.4988-1-jglauber@cavium.com>
 <20170829131238.4988-2-jglauber@cavium.com>
 <20170830175406.ygmathi3b5orzyqy@pd.tnic>
Message-ID: <20170831084606.GA14296@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 07:54:06PM +0200, Borislav Petkov wrote:
> On Tue, Aug 29, 2017 at 03:12:32PM +0200, Jan Glauber wrote:
> > The memory controller on ThunderX/OcteonTX systems does not
> > support power management. Therefore remove the suspend/resume
> > callbacks.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > ---
> >  drivers/edac/thunderx_edac.c | 21 ---------------------
> >  1 file changed, 21 deletions(-)
> 
> Just when I thought I'd pick that one up now because it is removing
> stuff:
> 
> drivers/edac/thunderx_edac.c:817:14: error: ?thunderx_lmc_suspend? undeclared here (not in a function)
>   .suspend  = thunderx_lmc_suspend,
>               ^~~~~~~~~~~~~~~~~~~~
> drivers/edac/thunderx_edac.c:818:14: error: ?thunderx_lmc_resume? undeclared here (not in a function)
>   .resume   = thunderx_lmc_resume,
>               ^~~~~~~~~~~~~~~~~~~
> scripts/Makefile.build:308: recipe for target 'drivers/edac/thunderx_edac.o' failed
> make[1]: *** [drivers/edac/thunderx_edac.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1682: recipe for target 'drivers/edac/' failed
> make: *** [drivers/edac/] Error 2

Argh... forgot to build test the single patches. 

> Please make sure you build and test every patch before submitting.
> You're lucky I can at least build arm64 on my x86 workstation. :-)

Sorry for that. The whole series builds because I removed the suspend/resume
callbacks during the move to the soc driver.

--Jan

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
