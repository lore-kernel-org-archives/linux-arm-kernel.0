From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 12:46:57 +0000
Subject: [PATCH 2/2] ASoC: sgtl5000: clean up sgtl5000_enable_regulators()
In-Reply-To: <20131217123946.GN6691@S2101-09.ap.freescale.net>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
 <20131217015939.GM3185@sirena.org.uk>
 <20131217021610.GA7172@S2101-09.ap.freescale.net>
 <20131217113705.GP3185@sirena.org.uk>
 <20131217123946.GN6691@S2101-09.ap.freescale.net>
Message-ID: <20131217124657.GW3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 08:39:48PM +0800, Shawn Guo wrote:

> Hmm, I do not quite follow.  The regulator core needs to know whether a
> regulator device is present or absent, before the regulator is
> registered, so that regulator core can decide to return -EDEFER_PROBE
> or -ENODEV when consumer calls regulator_get_optional() to get the
> regulator.  Are you saying platform can call
> regulator_has_full_constraints() to help regulator core to make this
> decision?  I do not understand how it works.

It tells the core that it now knows about all regulator mappings so it
knows if it's not got a mapping none will ever appear.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/fd201ce3/attachment.sig>
