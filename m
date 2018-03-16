From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 16 Mar 2018 11:47:12 +0300
Subject: [PATCH -next] ASoC: mediatek: mt2701: drop unnessary
 snd_soc_unregister_component()
In-Reply-To: <1521185516-164333-1-git-send-email-weiyongjun1@huawei.com>
References: <1521185516-164333-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180316084712.hh4ll7hfsncqqsos@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 07:31:56AM +0000, Wei Yongjun wrote:
> It's not necessary to unregister a component registered
> with devm_snd_soc_register_component().
> 
> Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to componen")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>


This fixes a double free on unload, right?

regards,
dan carpenter
