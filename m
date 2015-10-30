From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Oct 2015 14:46:43 +0100
Subject: [PATCH v4] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <BN3PR0301MB0867C51A52319367F981C630FE230@BN3PR0301MB0867.namprd03.prod.outlook.com>
References: <1442480614-32345-1-git-send-email-b18965@freescale.com>
 <5073362.oArWDzYkxD@wuerfel>
 <BN3PR0301MB0867C51A52319367F981C630FE230@BN3PR0301MB0867.namprd03.prod.outlook.com>
Message-ID: <3938714.zt8Y4X5ull@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 October 2015 14:40:21 Huan Wang wrote:
> > 
> > Ok. What I was suggesting above though was to try to pinpoint exactly
> > where it goes wrong. You have verified that it does not crash before the
> > page tables are enabled, but that is very early. You have also shown
> > that the kernel crashes before the point at which the 'Booting Linux on
> > physical CPU 0xf00' message is printed to the kernel, but that is *much*
> > later: setup_arch() calls parse_early_param(), which in turn sets up
> > early_console_write(). This means the 'Booting Linux on physical CPU
> > 0xf00'
> > is still stuck in the log buffer and you may have crashed someone
> > inbetween.
> > 
> > If you can call printascii(), you can try to do that just after enabling
> > the page tables to see if that was the problem like you suspect, or
> > otherwise add more printascii() statements between __turn_mmu_on and
> > parse_early_param() to pinpoint the exact code that breaks.
> [Alison Wang] Thank you very much for your help. The issue is fixed.
> 

Ah, very good. I'm curious what caused the problem in the end.

	Arnd
