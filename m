From: jekarlson@gmail.com (Emil Karlson)
Date: Wed, 26 Jul 2017 20:44:18 +0300
Subject: [RESEND PATCH 0/2] crypto/rockchip: fix some issue which causes
 crypto failed
In-Reply-To: <1500859394-1799-1-git-send-email-wzz@rock-chips.com>
References: <1500859394-1799-1-git-send-email-wzz@rock-chips.com>
Message-ID: <CAELSAVZAs=Tqz_yHb2u8StXFeC550Tm98jqmnRFZLRmFCqs0bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings

While I am not getting the original error anymore, using dm-crypt
still fails at cryptsetup luksOpen with [rk_ablk_rx:331] Lack of data
https://users.aalto.fi/~jkarlson/files/rk3288-fail_2017-07-24.jpg

Test platform: Asus chromebook C201/rk3288 linux-4.12.3+ this patchset

Best Regards
-Emil

On Mon, Jul 24, 2017 at 4:23 AM, zain wang <wzz@rock-chips.com> wrote:
> These patches fix some bugs on rockchip's crypto which would cause crypto failed.
>
> zain wang (2):
>   crypto: rockchip - move the crypto completion from interrupt context
>   crypto: rockchip - return the err code when unable dequeue the crypto
>     request
>
>  drivers/crypto/rockchip/rk3288_crypto.c            | 58 +++++++++++-----------
>  drivers/crypto/rockchip/rk3288_crypto.h            |  4 +-
>  drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c | 17 ++++++-
>  drivers/crypto/rockchip/rk3288_crypto_ahash.c      | 16 +++++-
>  4 files changed, 62 insertions(+), 33 deletions(-)
>
> --
> 1.9.1
>
>
