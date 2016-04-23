From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sat, 23 Apr 2016 15:20:57 +0530
Subject: [PATCH 0/2] Embedding Position Independent Executables
In-Reply-To: <20160422224958.GD17051@piout.net>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160404095757.GR19428@n2100.arm.linux.org.uk>
 <20160422224958.GD17051@piout.net>
Message-ID: <20160423095057.GA2630@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Apr 23, 2016 at 12:49:58AM +0200, Alexandre Belloni wrote:

> I think Heiko clarified it but there are actually multiple platforms
> that will benefit from this infrastructure. I can name at least at91,
> rockchip, sunxi and am335x. On am335x, this has been solved by running
> that code on the cortex M3 instead of doing that from Linux but it
> forces to compile and load a firmware on the cortex M3 so it is not
> available for anything else.

afaik on am335x, it has been solved so far by not yet supporting
suspend-resume in mainline ;)

afaiu, am335x suspend-resume has 2 parts, one run in A8 & other in M3.
Saving & restoring RAM config, putting to self refresh in addition to
wfi invocation is handled by A8 code running in OCMC, while M3 cuts A8
clock & does other PM things that can't be done in A8.

Regards
afzal
