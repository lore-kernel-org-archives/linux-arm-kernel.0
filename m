From: beagleboard@davidjohnsummers.uk (David Summers)
Date: Sun, 23 Sep 2018 17:44:33 +0100
Subject: [PATCH v4 0/2] Reworked rk3288-tinker-s devicetree
In-Reply-To: <20180923113807.11558-1-heiko@sntech.de>
References: <20180923113807.11558-1-heiko@sntech.de>
Message-ID: <1f9a2dc0-0eac-8aa2-41a4-5d6117c72aea@davidjohnsummers.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Heiko,

Yes I like the refactoring. Patch 1 effectively making no changes, but 
rearranging files so the tinker board device tree can be used as a 
template for others. Patch 2 then adding the Tinker Board S, with the 
only major change being adding the eMMC - and that change is relatively 
simple.

These two patches by themselves are enough to get the Tinker Board S 
functional, and that they should be uncontroversial hopefully means they 
will go through.

The WiFi change, I also had my doubts over - hence why it was a separate 
patch. For what it is worth, it was what was needed to get the WiFi up 
on: https://paste.pound-python.org/show/SFdoQHC3z2hvoufdAmxs/ - hence 
why submitted.

My own problems with it:
1) I believe that the tinker board has wi-fi in which case it should be 
common - but know of no one with a plain tinker board - hence why to 
post, so if someone can test. Then if so apply to the tinker-board.dtsi
2) Parts of the patch are clear (e.g. enabling sdio0 - as that is how 
the wifi data is wired up); but other parts (e.g. uart0 pinctrl, and the 
sdio_pwrseq) and although these seem needed - the connection is vague to 
the WiFi. What can I say, but these were in the original ASUS patch.

So on WiFi I can understand if discussion is needed.

Regards,

David.

P.S. and thanks for the git commands - first time I've used git in 
anger, e.g. hadn't realised the importance of the "git commit" message 
for how it is used in "git format-patch". I'll get better at this with 
time ....

On 23/09/2018 12:38, Heiko Stuebner wrote:
> Hi David,
>
> I've adpated your patches 1+2 like so and would like to add them this way
> later on. Biggest change is of course making patch 1 solely about moving
> the shared parts to the dtsi and adding the tinker-s.dts including the
> emmc in the second patch.
>
> Apart from that you can also see some previously missing style-related
> fixes. For example patch subject lines are somewhat specific, to allow
> people browsing the git history to realize the core patch contents just
> from the "headline" and also use the "correct" prefixes which vary
> depending on the subsystem your changing.
>
> For future patches you can just do a "git log --oneline arch/arm/boot/dts"
> (change directory depending on location of the change of course), to
> see that arm32 dts use "ARM: dts: $soc-vendor: foo".
>
>
> Also providing a commit message describing the individual change
> in a bit more detail is important.
>
> The wifi patch is a different issue, so I'll reply there.
>
>
> Heiko
>
> David Summers (2):
>    ARM: dts: rockchip: move shared tinker-board nodes to a common dtsi
>    ARM: dts: rockchip: add rk3288-based Tinker board S
>
>   .../devicetree/bindings/arm/rockchip.txt      |   4 +
>   arch/arm/boot/dts/Makefile                    |   1 +
>   arch/arm/boot/dts/rk3288-tinker-s.dts         |  26 +
>   arch/arm/boot/dts/rk3288-tinker.dts           | 498 +----------------
>   arch/arm/boot/dts/rk3288-tinker.dtsi          | 504 ++++++++++++++++++
>   5 files changed, 537 insertions(+), 496 deletions(-)
>   create mode 100644 arch/arm/boot/dts/rk3288-tinker-s.dts
>   create mode 100644 arch/arm/boot/dts/rk3288-tinker.dtsi
>
