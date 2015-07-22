From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 22 Jul 2015 08:38:56 +0100
Subject: [PATCH 11/12] [media] tsin: c8sectpfe: Add Kconfig and Makefile
 for the driver.
In-Reply-To: <1435216998.4528.100.camel@tiscali.nl>
References: <1435158670-7195-1-git-send-email-peter.griffin@linaro.org>
 <1435158670-7195-12-git-send-email-peter.griffin@linaro.org>
 <1435216998.4528.100.camel@tiscali.nl>
Message-ID: <20150722073856.GA32601@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Thanks for reviewing.

On Thu, 25 Jun 2015, Paul Bolle wrote:

> On Wed, 2015-06-24 at 16:11 +0100, Peter Griffin wrote:
> > --- /dev/null
> > +++ b/drivers/media/tsin/c8sectpfe/Makefile
> 
> > +c8sectpfe-y += c8sectpfe-core.o c8sectpfe-common.o c8sectpfe-dvb.o
> > +
> > +obj-$(CONFIG_DVB_C8SECTPFE) += c8sectpfe.o
> > +
> > +ifneq ($(CONFIG_DVB_C8SECTPFE),)
> > +	c8sectpfe-y += c8sectpfe-debugfs.o
> > +endif
> 
> Isn't the above equivalent to
>     c8sectpfe-y += c8sectpfe-core.o c8sectpfe-common.o c8sectpfe-dvb.o c8sectpfe-debugfs.o
> 
>     obj-$(CONFIG_DVB_C8SECTPFE) += c8sectpfe.o
> 
> Or am I missing something subtle here?

No I think I just messed up. Will fix in v2.

I suspect what happened  was I was starting to add a CONFIG_DVB_C8SECTPFE_DEBUGFS
Kconfig option, and then forgot ;)

In v2 I have added a "select DEBUG_FS" to Kconfig for the driver, and put it all on one
line. Also at the same time fixing some other Kconfig dependencies I noticed so
it now has 'select LIBELF_32' and 'select FW_LOADER'.

regards,

Peter.
