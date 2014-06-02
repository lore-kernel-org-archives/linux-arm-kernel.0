From: dvhart@linux.intel.com (Darren Hart)
Date: Mon, 02 Jun 2014 08:16:08 -0700
Subject: [PATCH 2/2] clkdev: Export clk_register_clkdev
In-Reply-To: <20140602123522.GB31751@sirena.org.uk>
References: <1401738379-4107-1-git-send-email-chiau.ee.chew@intel.com>
 <1401738379-4107-3-git-send-email-chiau.ee.chew@intel.com>
 <20140602123522.GB31751@sirena.org.uk>
Message-ID: <CFB1E2EA.94DEE%dvhart@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/2/14, 5:35, "Mark Brown" <broonie@kernel.org> wrote:

>On Tue, Jun 03, 2014 at 03:46:19AM +0800, Chew Chiau Ee wrote:
>> From: Darren Hart <dvhart@linux.intel.com>
>> 
>> Allow spi-pxa2xx-pci with common clock framework support to build as a
>> module by exporting clk_register_clkdev.
>
>This needs to be patch 1 in the series not patch 2 since the change to
>the driver to use the exported symbol depends on this rather than the
>other way around.
>

That was going to be my only comment as well. It's important to ensure
things build consistently through the git history. Git bisect is a key use
case here, breaking that makes for very cranky kernel engineers :-)
Dependencies first, new mechanisms second.

-- 
Darren Hart					Open Source Technology Center
darren.hart at intel.com				            Intel Corporation
