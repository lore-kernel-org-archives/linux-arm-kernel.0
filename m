From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 Aug 2014 10:07:45 +0200
Subject: [PATCH 0/3] Thermal reset support in PMC
In-Reply-To: <1407226380-747-1-git-send-email-mperttunen@nvidia.com>
References: <1407226380-747-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <20140813080744.GD7735@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 11:12:57AM +0300, Mikko Perttunen wrote:
> Hi,
> 
> this series adds support for hardware-triggered thermal reset to the PMC
> driver. Namely, it adds device tree properties for specifying the I2C
> command to be sent when thermtrip is triggered. It is to be noted
> that thermtrip won't be ever triggered without a soctherm driver to
> calibrate the sensors, but I'll follow up with that patch.
> 
> pmc.c required some juggling around to make the match data usable in
> probe, since I didn't want to put the code into the initcall either, since
> the soctherm driver won't be initialized by that point anyway.
> 
> Series tested on Jetson-TK1. Should work on Tegra30 and Tegra114 too.

Can you describe the procedure used to test this? We currently have a
bunch of features in Tegra that some people have tested at some point
during development but the test procedures never got documented. That
means whenever we want to test something we need to go and reinvent a
bunch of tests after the fact.

So what I'd like to start doing is collect tests (preferably in some
scripted way) so that they can be kept in a repository that people can
easily clone and run on devices.

Could you provide something like that for thermtrip?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/daa816b7/attachment.sig>
