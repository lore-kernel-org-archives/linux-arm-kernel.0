From: zhongjiang@huawei.com (zhong jiang)
Date: Wed, 19 Sep 2018 17:01:32 +0800
Subject: [PATCH] drm: sun4i: Fix a uninitialized variable warning.
In-Reply-To: <20180919084719.6ymf6h4eftomfab3@flea>
References: <1537255520-41614-1-git-send-email-zhongjiang@huawei.com>
 <20180919084719.6ymf6h4eftomfab3@flea>
Message-ID: <5BA2106C.2080007@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/9/19 16:47, Maxime Ripard wrote:
> On Tue, Sep 18, 2018 at 03:25:20PM +0800, zhong jiang wrote:
>> Fix the following compile warning:
>>
>> drivers/gpu/drm/sun4i/sun4i_tcon.c:1088: warning: 'has_lvds_alt' may be used uninitialized in this function [-Wmaybe-uninitialized]
>> bool has_lvds_rst, has_lvds_alt, can_lvds;
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> I can't see any code path that would lead to an uninitialized usage of
> that variable.
>
> Which compiler produced that warning? I tried building it today with
> gcc 8.1.1, and I don't see that warning either.
>
> Maxime
>
I indeed  hit the issue.  the gcc version is
gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609

Thanks,
zhong jiang
