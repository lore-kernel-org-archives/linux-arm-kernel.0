From: zhangfei.gao@gmail.com (Zhangfei Gao)
Date: Wed, 11 Dec 2013 13:47:16 +0800
Subject: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <001f01cef1c2$6bd0ab70$43720250$%jun@samsung.com>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
 <1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
 <001f01cef1c2$6bd0ab70$43720250$%jun@samsung.com>
Message-ID: <CAMj5Bkgwzq5+aewF2vOJq3aDMk0yy8WVQOzdboCmMtrx1vi4nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Seungwon

On Thu, Dec 5, 2013 at 10:00 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:

>> +static DEFINE_SPINLOCK(mmc_tuning_lock);
> Can the above variables be involved in dw_mci_k3_priv_data instead of global declaration?
>
Unfortunately, this can be be put in priv_data, which is different
instance for different controller.
Here need protect register shared by different controllers


>> +static int dw_mci_k3_setup_clock(struct dw_mci *host)
>> +{
>> +     dw_mci_k3_tun(host, MMC_TIMING_LEGACY);
> Is it necessary here?
> When card-init, MMC_TIMING_LEGACY will be passed via dw_mci_k3_set_ios().

Read register will fail if not set these register earlier, and set_ios
is too late.
Same reason for resume.

Thanks
