From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 24 Feb 2012 11:49:41 +0000
Subject: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
In-Reply-To: <1330076289.4102.517.camel@sokoban>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
 <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
Message-ID: <20120224114940.GB5450@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 11:38:09AM +0200, Tero Kristo wrote:
> On Thu, 2012-02-23 at 15:34 +0000, Mark Brown wrote:

> > Since you're using min_uV as the "register value" you probably ought to
> > be returning that as the selector too and supplying a list_voltage()
> > which just passes the selector back in case something tries to use it
> > and gets confused.

> I was thinking at some point about adding a list_voltage for these
> regulators, however I dropped that idea, because the regulators can
> support a range of voltages (from min to max) with some stepping value.
> But... if you propose that the list_voltage would just return the
> current voltage back, wouldn't that also potentially confuse the user
> more, as it can only see the single voltage and nothing else, maybe
> making it to think that the regulator can only support one voltage
> level?

Yes, that'd be completely broken.  You'd need to just return the
selector back which would tell them that they had voltage control in
microvolt steps.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120224/d9f2bef4/attachment.sig>
