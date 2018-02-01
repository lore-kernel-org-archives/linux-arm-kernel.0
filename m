From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Thu, 1 Feb 2018 10:03:11 +0100
Subject: Patch submission process about at91 DTS
In-Reply-To: <20180131170453.GA16869@tp.shaiton.org>
References: <20180131170453.GA16869@tp.shaiton.org>
Message-ID: <1337f0d7-c112-e9db-6677-cbd2c58b1b06@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi K?vin,

Le 31. 01. 18 ? 18:04, K?vin Raymond a ?crit?:
> Hi there,
> 
> We have several at91-kizbox* DTSs and I have few patches to suggest.
> The idea is to split one dts over dtsi + several dts.
> 
> My current patches are based an tested over the linux repo[0] against the
> master branch (4e19652 Update the RISC-V MAINTAINERS file).
> 
> Should I rebase them against the linux-at91[1] repository? Which branch,
> at91-next? I would love them to reach the 4.14 branch but am not sure of
> the right path to submit those changes.
> 

Linux 4.14 is already out, so only patches for a stable release can be
backported. See in Documentation/process/stable-kernel-rules.rst for the
rules. I guess that your patches do not apply for stable. So your patches
will be applied to a latter release (4.16 if you are lucky as the merge window
is now opened but most probably 4.17+).

For the submission process itself, please read Documentation/process/* and
especially "5.Posting.rst" and "submitting-patches.rst". There is also a
documentation specific to DT patches in Documentation/devicetree/bindings/
submitting-patches.txt.

TL;DR look into the MAINTAINERS file or use ./scripts/get_maintainer.pl.
For your AT91 patches, you should CC the maintainers:

- Nicolas Ferre <nicolas.ferre@microchip.com>
- Alexandre Belloni <alexandre.belloni@free-electrons.com>

You should also CC the DT mainling list.

Finally the AT91 Git tree is here [1]. Use that unless told differently by the
maintainers.

Best,
Florian

[1] git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
