From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Sep 2018 09:02:06 -0700
Subject: [PATCH -next] pinctrl: mediatek: paris: fix return value check in
 mtk_paris_pinctrl_probe()
In-Reply-To: <1537424488-23485-1-git-send-email-weiyongjun1@huawei.com>
References: <1537424488-23485-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <CACRpkdZ=ppVeX5-7AGkFryDwh3eHpviFu+gNsda5sKYS54FEwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 11:12 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:

> In case of error, the function devm_kmalloc_array() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
>
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied with Sean's ACK.

Yours,
Linus Walleij
