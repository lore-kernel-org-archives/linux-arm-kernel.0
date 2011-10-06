From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 06 Oct 2011 17:55:32 +0200
Subject: [PATCH 2/2] hw_random: add driver for atmel true hardware random
	number generator
In-Reply-To: <20111006154904.GE12975@sirena.org.uk> (Mark Brown's message of
	"Thu, 6 Oct 2011 16:49:07 +0100")
References: <1317915694-27564-1-git-send-email-jacmet@sunsite.dk>
	<1317915694-27564-2-git-send-email-jacmet@sunsite.dk>
	<20111006154904.GE12975@sirena.org.uk>
Message-ID: <8762k23yiz.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Mark" == Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

 Mark> On Thu, Oct 06, 2011 at 05:41:34PM +0200, Peter Korsgaard wrote:
 >> +	trng->clk = clk_get(&pdev->dev, NULL);
 >> +	if (IS_ERR(trng->clk))
 >> +		return PTR_ERR(trng->clk);
 >> +
 >> +	ret = clk_enable(trng->clk);
 >> +	if (ret)
 >> +		goto err_enable;

 Mark> Is it worth enabling the hardware enabled only when the device is open?

Potentially, though I doubt it uses significant power. I kept it like
this for simplicity, to match the other drivers and because hw_random
doesn't have an open/close callback (init is called right away in
hwrng_register or on current change).

-- 
Bye, Peter Korsgaard
