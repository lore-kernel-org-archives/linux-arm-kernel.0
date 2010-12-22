From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Dec 2010 00:23:54 +0100
Subject: Fwd: [PATCH 7/23]  Alternative mmc structure to support pxa168,
	pxa910, mmp2 family SD
In-Reply-To: <C514DA21-446D-4153-B5B9-E4AE4D0A06CA@marvell.com>
References: <C8F2F5E1-E72D-4679-AB8F-748CBE736262@marvell.com>
	<C514DA21-446D-4153-B5B9-E4AE4D0A06CA@marvell.com>
Message-ID: <201012230023.55062.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 December 2010 00:06:51 Philip Rakity wrote:
> 
> host-&gt;ops-&gt;platform_reset_exit(host, mask);<br>+<br> <span class=3D"A=
> pple-tab-span" style=3D"white-space:pre">	</span>if (host-&gt;quirks &amp; =
> SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)<br> <span class=3D"Apple-tab-span" st=
> yle=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" style=3D"whi=
> te-space:pre">	</span>sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);<=
> br> }<br>diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h<b=
> r>index 6e0969e..9dd7bc1 100644<br>--- a/drivers/mmc/host/sdhci.h<br>+++ b/=
> drivers/mmc/host/sdhci.h<br>@@ -222,6 +222,8 @@ struct sdhci_ops {<br> <spa=
> n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>void (*platfor=
> m_send_init_74_clocks)(struct sdhci_host *host,<br> <span class=3D"Apple-ta=

This must be the first time I've seen someone post a patch as HTML ;-)

Please reread Documentation/SubmittingPatches. I doubt that you will be
able to make your current email client do the right thing, so best
start looking@"git send-email", which should solve most of the basic
problems you currently experience.

Feel free to send the patch to me in private (after sending it to yourself
first and convincing yourself that you did it right) first if you want to
avoid spamming the mailing lists with more patches that are somewhat wrong.

	Arnd
