From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Nov 2013 20:38:38 +0000
Subject: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver
 about regulator.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F828783E6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
 <20131101185045.GG2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131106100305.GI11602@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F828783E6@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20131107203838.GC2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 03:01:02AM +0000, Li Xiubo wrote:
> > > The SGTL5000 is based on regulators and when it is disabled, there
> > > will be an error returns directly while the SGTL5000 codec is probing.

> > What makes you say this?  

> static int ldo_regulator_register(struct snd_soc_codec *codec,
>                                 struct regulator_init_data *init_data,
>                                 int voltage)

If the regulator is not used in the system then why is the driver
getting as far as trying to register it?  Surely this is a system
configuration error?  This all sounds like some problem with either the
system integration or the driver which is causing it to try to register
the regulator needlessly - you should be fixing that problem, not adding
ifdefs.  I'm still unclear on exactly what the issue is so it's hard to
say exactly what the best way forwards is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131107/fd5aef54/attachment-0001.sig>
