From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 26 Nov 2012 21:55:33 -0800
Subject: [PATCH 1/2] ASoC: davinci-mcasp: Add pinctrl support
In-Reply-To: <20121126114511.GE9411@opensource.wolfsonmicro.com> (Mark Brown's
 message of "Mon, 26 Nov 2012 11:45:11 +0000")
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
 <1353557099-21599-2-git-send-email-gururaja.hebbar@ti.com>
 <20121126114511.GE9411@opensource.wolfsonmicro.com>
Message-ID: <87y5hn1tey.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Mark" == Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

Hi,

 Mark> On Thu, Nov 22, 2012 at 09:34:58AM +0530, Hebbar, Gururaja wrote:
 >> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 >> +	if (IS_ERR(pinctrl))
 >> +		dev_warn(&pdev->dev,
 >> +			"pins are not configured from the driver\n");

 Mark> Since the driver is happy to continue without the pins why is it
 Mark> bothering requesting them in the first place?  In other words, this
 Mark> should be a hard error.

Sorry, I disagree. As was discussed recently, there's several reasons
why the pinctrl call might fail, and not all are fatal (E.G. pinmux
already setup by bootloader):

http://article.gmane.org/gmane.linux.kernel/1399756

-- 
Bye, Peter Korsgaard
