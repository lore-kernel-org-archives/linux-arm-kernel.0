From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 09 Feb 2013 13:45:40 +0000
Subject: [PATCH v7 06/15] gpio: find gpio base by ascend order
In-Reply-To: <1358494279-16503-7-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130209134540.BA5EB3E30EC@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jan 2013 15:31:10 +0800, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> gpiochip_find_base() always tries to find valid gpio with descend order.
> It's inconvient if gpio information is passing from DTS. Now try to find
> valid gpio with ascend order.

Why is it more convenient? Just to make the numbers smaller? The reason
it uses a descending search is to mimimize the possibility of collision
with fixed GPIO numbers.

g.
