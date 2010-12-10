From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Dec 2010 09:41:53 -0800
Subject: [PATCH 12/11] omap1: Fix gpio mpuio bank to work for
	multi-omap for 7xx/15xx/16xx
In-Reply-To: <201012101704.37054.jkrzyszt@tis.icnet.pl>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<20101204212554.GM17222@atomide.com>
	<20101207232315.GE17435@atomide.com>
	<201012101704.37054.jkrzyszt@tis.icnet.pl>
Message-ID: <20101210174153.GU3054@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101210 08:05]:
> > We need to divide the 15xx/16xx offset by 2 for 7xx. Use bank->stride
> > for that. This allows us to get rid of the duplicate defines for the
> > MPUIO registers.
> >
> > Note that this will cause omap-keypad.c driver to not work on 7xx.
> > However, the right fix there is to move over to gpio-keys instead as
> > suggested by Cory Maccarrone <darkstar6262@gmail.com> and
> > Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>.
> >
> > Cc: Cory Maccarrone <darkstar6262@gmail.com>
> > Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Thanks, will now merge the gpio into omap-for-linus for the next
merge window.

Tony
