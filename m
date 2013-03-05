From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 5 Mar 2013 17:36:12 +0800 (HKT)
Subject: [RFC PATCH] ARM: mm: disable kmap_high_get() for SMP
In-Reply-To: <1362372667-953-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1362372667-953-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <alpine.LFD.2.03.1303051642110.28820@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Mar 2013, Joonsoo Kim wrote:

> With SMP and enabling kmap_high_get(), it makes users of kmap_atomic()
> sequential ordered, because kmap_high_get() use global kmap_lock().
> It is not welcome situation, so turn off this optimization for SMP.

I'm not sure I understand the problem.

The lock taken by kmap_high_get() is released right away before that 
function returns and therefore this is not actually serializing 
anything.


Nicolas
