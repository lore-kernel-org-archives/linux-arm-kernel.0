From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 12 Dec 2010 15:07:27 +0100
Subject: [PATCH v4] mach-at91: Support for gsia18s board added
In-Reply-To: <1292135848.2456.19.camel@homepc>
References: <1292000411-6691-1-git-send-email-plyatov@gmail.com>
	<20101212005048.GH19897@game.jcrosoft.org>
	<1292135848.2456.19.camel@homepc>
Message-ID: <20101212140727.GI19897@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:37 Sun 12 Dec     , Igor Plyatov wrote:
> Dear Jean-Christophe,
> 
> > On 20:00 Fri 10 Dec     , Igor Plyatov wrote:
> > > The GS_IA18_S (GMS) is a carrier board from GeoSIG Ltd used with the
> > > Stamp9G20 SoM from Taskit company.
> > > It operate as an internet accelerometer.
> > > 
> > > Signed-off-by: Igor Plyatov <plyatov@gmail.com>
> > > ---
> > >  arch/arm/configs/gsia18s_defconfig        |  147 +++++++
> > please no new defconfig
> > start to merge them
> 
> I already write that it is not possible to use same defconfig for our
> board and Stamp9G20, because 69 different CONFIG_xxx options required
> for our machine (compared with Portux G20 and Stamp9G20) and our options
> very excessive for other devices based on the Stamp9G20.
> This device for the embedded, where space constraints exists for memory
> and it is required to save resources as more as possible.
sorry as I explain before if you have exclusive option you need to create
kconfig options which are board specific to manage them
we work to reduce the number of defconfig in the mainline
and it's not PortuxG20 and Stamp9g20 specific but to have only one defconfig
for all 9g20 at a first step and late for all sam9
> 
> > your patch contain a lots of whitespace please fix it
> 
> There is no problems with whitespace. This patch checked by
> scripts/checkpatch.pl twice. It seems your mailer corrupt this patch.
my mailer no way mutt does not do it
and when I edit with vim I saw the whitespace too
please check again
> 
> > > +
> > > +/*
> > > + * Up to date linux/arch/arm/tools/mach-types database required to support this.
> > > +MACHINE_START(GSIA18S, "GS_IA18_S")
> > > +*/
> > > +MACHINE_START(STAMP9G20, "GS_IA18_S")
> > if you do this you must use system_rev to identify the board
> 
> I can cite Christian Glindkamp:
> "And for different carrier boards, system_rev does not make sense at
> all."
> 
> Please, use more testimony why it is required to use system_rev here.
> Yours position does not clear for me.
> You can point me to the right documentation or discussion about this
> requirements in the mail archives...
two bards with the same machine id NACK as we can not compile them in the same
kernel and this a target we all work on to allow
if you want to tuse the same machine id as I did for other boards you must use
system_rev or any detection to identify tehm

Best Regards,
J.
