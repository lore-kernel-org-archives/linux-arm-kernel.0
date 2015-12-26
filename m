From: eric@anholt.net (Eric Anholt)
Date: Sat, 26 Dec 2015 14:38:05 -0800
Subject: [PATCH v2 8/8] ARM: bcm2835: Add Kconfig support for bcm2836
In-Reply-To: <1450310115-22163-9-git-send-email-eric@anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <1450310115-22163-9-git-send-email-eric@anholt.net>
Message-ID: <87y4cg96pe.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> This should be a complete port of bcm2835 functionality to bcm2836
> (Raspberry Pi 2).
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> v2: Implement Arnd's feedback to not split to ARCH_BCM2836, and
>     instead use more conditionals in ARCH_BCM2835.  Also reduce diff
>     between 2835 and 2836.
>
>  arch/arm/Kconfig.debug     | 10 ++++++++--
>  arch/arm/boot/dts/Makefile |  3 ++-
>  arch/arm/mach-bcm/Kconfig  |  8 ++++----
>  3 files changed, 14 insertions(+), 7 deletions(-)

I noticed a minor bug in this commit, that the dts/Makefile hunk should
be in the Pi2 DT patch, instead.  Otherwise the -soc branch for
submitting this doesn't build on its own before the merge of all the
branches together.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151226/768f1cc0/attachment.sig>
