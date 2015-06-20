From: benoar@dolka.fr (Benjamin Cama)
Date: Sat, 20 Jun 2015 02:28:39 +0200
Subject: Linkstation Mini and __machine_arch_type problem, not booting
 since 3.8
In-Reply-To: <20150619114152.GA2936@io.lakedaemon.net>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <55827D64.1090307@free-electrons.com> <1434678624.4767.22.camel@dolka.fr>
 <5583E1D9.2010002@free-electrons.com>
 <20150619114152.GA2936@io.lakedaemon.net>
Message-ID: <1434760119.5177.6.camel@dolka.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 19 juin 2015 ? 11:41 +0000, Jason Cooper a ?crit :
> On Fri, Jun 19, 2015 at 11:33:13AM +0200, Gregory CLEMENT wrote:
> > On 19/06/2015 03:50, Benjamin Cama wrote:
> > > My main problem is getting some debug messages: no amount of "debug"
> > > and "loglevel" on the command line seems to change anything. Is it too
> > > early in the boot process to get anything output or am I doing
> > > something wrong? (I activated some configs for debugging, but I may
> > > have missed the good one)
> > 
> > Try to activate earlyprintk. For this you have to select CONFIG_EARLY_PRINTK
> > which depend on DEBUG_LL. You will also have to add the argument
> > "earlyprintk" to your kernel parameters.

Yes, this is what I tried before without success, but then I looked
again and realized? that I missed the option to choose the correct
output just below the ?Kernel low-level debugging functions? option
because the text line was too long and I didn't see it chose
?EmbeddedICE DCC channel? by default instead of the UART. Big fail for
me here.

Still, no output.

> SERIAL_OF_PLATFORM?

Oh, and that was it! Why isn't it selected by the DT config? I see that
it's in the defconfigs, but selected nowhere by any option. Is there a
particular reason for this?

Then I saw the kernel log, I witnessed that it worked well, it just
couldn't find a root fs (I was booting with dummy parameters). So the
DT I made is actually working!

Thanks for your help, the patch will be following,
--
benjamin
