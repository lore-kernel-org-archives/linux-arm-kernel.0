From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Jul 2014 19:45:17 +0100
Subject: Regarding module size change in ARM kernel
In-Reply-To: <CAKuQT6xdcsQM6a4PXO40SvbqSdccJ7bkS6Arz0yqU9RRpcoVQA@mail.gmail.com>
References: <CAKuQT6xdcsQM6a4PXO40SvbqSdccJ7bkS6Arz0yqU9RRpcoVQA@mail.gmail.com>
Message-ID: <20140716184517.GR21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 05:51:16PM +0100, Venkateswar Rao Goli wrote:
> Hi there,
> 
> I'm running out of module size memory i.e, 14MB  ( CONFIG_HIGHMEM is
> enabled in config ) .

Quite simply, don't have such big modules.  Really.  If you're filling
14MB you're doing something very wrong.

> I've tried to increase by changing as below,
> could you please let us know if it would cause any regressions in any
> of the application or scenario ?

You're increasing the chances that the module text won't be able to reach
the kernel text, and so relocations will fail.  18MB should work fine
provided your kernel is no larger than 14MB.

But seriously, do something about your huge modules.  Filling 14MB is
just insane.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
