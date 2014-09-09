From: axel.lin@ingics.com (Axel Lin)
Date: Tue, 9 Sep 2014 19:11:46 +0800
Subject: [PATCH] regulator: mc13xxx: add missing of_node_get()
In-Reply-To: <1410260825-21667-1-git-send-email-guodong.xu@linaro.org>
References: <1410260825-21667-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <CAFRkauBhzHot9=z-Jv-rvdLaSWSfyYSULMKqcVX+tiHcXrxt_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-09-09 19:07 GMT+08:00 Guodong Xu <guodong.xu@linaro.org>:
> mc13xxx_parse_regulators_dt() goes through dt tree to search for regulator
> sub-nodes. For each matched node, later on it will be used and registered
> into a regulator_dev.
>
> of_node_get() should be called to increase its refcount.

I think it's done by regulator core:

commit 63c7c9e16c8e92cc069854f2babdf82d2d38e4c7
regulator: core: Get and put regulator of_node

Regards,
Axel
