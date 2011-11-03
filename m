From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 3 Nov 2011 17:51:13 +0100
Subject: [PATCH v2] atmel/spi: fix missing probe during the switch to
	module_platform_driver
In-Reply-To: <20111103151855.GP12913@n2100.arm.linux.org.uk>
References: <1320331706-4946-1-git-send-email-plagnioj@jcrosoft.com>
	<1320333042-24880-1-git-send-email-plagnioj@jcrosoft.com>
	<20111103151855.GP12913@n2100.arm.linux.org.uk>
Message-ID: <20111103165113.GL7136@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:18 Thu 03 Nov     , Russell King - ARM Linux wrote:
> On Thu, Nov 03, 2011 at 11:10:42PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > in commit 940ab889
> 
> This kind of commit message is, frankly, utter crap.
> 
> With all the complaints that have been on this mailing list about raw
> commit IDs without saying what the commit was, it completely astounds
> me that someone in your position (allegedly a co-maintainer of a SoC)
> would make such an error.
> 
> Please generate a much better commit message.  Maybe something like:
> 
> ----
> Commit 940ab889 (blah blah blah) converted this driver to use
> module_platform_driver, but due to the use of platform_driver_probe(),
> this resulted in the call to atmel_spi_probe being lost.  Place the
> call to this function into the driver structure.
> 
> As atmel_spi_probe is marked __init, this will cause a section mismatch
> error, so ... <fill this in for the point below>
> ----
> 
> And, you're forgetting to fix this properly (maybe you don't care about
> section mismatch errors - are you going to create another patch for that
> as well?)  Did you even build-test this patch and pay attention to any
> warnings issued, or were you just pleased to get a zImage at the end?
> 
> static int __init atmel_spi_probe(struct platform_device *pdev)
> 
> __init is not compatible with having a pointer in the platform driver
> structure.  It needs to be __devinit.
this is an other fix I do not want to fix 2 issue in one commit and I do care
of mismatch erros I fix them all the time I send patch for some rm9200 few
weeks ago

Best Regards,
J.
