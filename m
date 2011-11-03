From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 3 Nov 2011 19:03:38 +0100
Subject: [PATCH v2] atmel/spi: fix missing probe during the switch to
	module_platform_driver
In-Reply-To: <20111103174338.GQ12913@n2100.arm.linux.org.uk>
References: <1320331706-4946-1-git-send-email-plagnioj@jcrosoft.com>
	<1320333042-24880-1-git-send-email-plagnioj@jcrosoft.com>
	<20111103151855.GP12913@n2100.arm.linux.org.uk>
	<20111103165113.GL7136@game.jcrosoft.org>
	<20111103174338.GQ12913@n2100.arm.linux.org.uk>
Message-ID: <20111103180338.GN7136@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:43 Thu 03 Nov     , Russell King - ARM Linux wrote:
> On Thu, Nov 03, 2011 at 05:51:13PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > this is an other fix I do not want to fix 2 issue in one commit and I do care
> > of mismatch erros I fix them all the time I send patch for some rm9200 few
> > weeks ago
> 
> It should not be a separate patch - it's all to do with fixing the
> original problem.

yes when we was supposed to swtch to module_platform_driver we use the .probe
which is suposed to be __devinit in this case but I was prefering to do it in
2 steps

as you wish and I found that the remove is __exit and supposed to be __devexit

Best Regards,
J.
