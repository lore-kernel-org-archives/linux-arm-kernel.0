From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 24 Feb 2014 21:01:37 -0800
Subject: [GIT PULL] bcm pinctrl rename
In-Reply-To: <20140221222947.GB13233@quad.lixom.net>
References: <CAEPRUYpCVpV7HwuO6c95ybk3yp1teJgW-9qwyHnjKbs03C9bgQ@mail.gmail.com>
 <20140221222947.GB13233@quad.lixom.net>
Message-ID: <CAEPRUYqUNxOT=KnhSmbXbL2e2tCs=jAhQqKLiVVc13okpBxHnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 2:29 PM, Olof Johansson <olof@lixom.net> wrote:
> (As per irc discussion). The rename isn't the right thing to do at this
> time in the release, but the binding needs to be tweaked before it ships
> in a full release, or we'll always need to live with it.
>
> So, I'll be happy to take the bindings piece and the dtsi piece (and the
> small edit to the driver to change the compatible string match table),
> but the file rename and Kconfig entry edit is 3.15 material.
>
> Please send new pull request with just that (or, if you prefer, just send the
> patches and we can apply them too).
>

Can you please pull the patches below. Note that if you wanto to
absolutely reduce this to the bone, you can drop the last patch in the
series titled "pinctrl: Rename Broadcom Capri pinctrl binding". That
is the documentation fixup, so the binding doc will be wrong until
3.15. But that will reduce the change to just 2 lines :)
 thanks,
   csd


The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:

  Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)

are available in the git repository at:

  git://github.com/broadcom/bcm11351.git
tags/bcm-for-3.14-pinctrl-reduced-rename

for you to fetch changes up to 735ea23c4868bf3123a4c79184e9206e0cc60211:

  pinctrl: Rename Broadcom Capri pinctrl binding (2014-02-24 20:25:54 -0800)

----------------------------------------------------------------
Rename pinctrl dt binding to restore consistency with
other bcm mobile bindings.

----------------------------------------------------------------
Christian Daudt (1):
      pinctrl: refer to updated dt binding string.

Sherman Yin (2):
      Update dtsi with new pinctrl compatible string
      pinctrl: Rename Broadcom Capri pinctrl binding

 Documentation/devicetree/bindings/pinctrl/{brcm,capri-pinctrl.txt =>
brcm,bcm11351-pinctrl.txt} | 8 ++++----
 arch/arm/boot/dts/bcm11351.dtsi
                          | 2 +-
 drivers/pinctrl/pinctrl-capri.c
                          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{brcm,capri-pinctrl.txt
=> brcm,bcm11351-pinctrl.txt} (98%)
