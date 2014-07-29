From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 29 Jul 2014 16:47:04 +0200
Subject: [PATCH v2 RESEND 2/4] drivers: of: initialize and assign reserved
 memory to newly created devices
In-Reply-To: <20140728141700.55FC4C408EA@trevor.secretlab.ca>
References: <1405326487-15346-1-git-send-email-m.szyprowski@samsung.com>
 <1405326487-15346-3-git-send-email-m.szyprowski@samsung.com>
 <20140728141700.55FC4C408EA@trevor.secretlab.ca>
Message-ID: <53D7B3E8.6070906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-07-28 16:17, Grant Likely wrote:
> On Mon, 14 Jul 2014 10:28:05 +0200, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Use recently introduced of_reserved_mem_device_init() function to
>> automatically assign respective reserved memory region to the newly created
>> platform and amba device.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> I'm still not okay with this patch. I don't think it is appropriate to
> add the hook into the generic path that gets used for every platform
> device. The devices that need reserved memory should explicitly request
> it, and any setup be done at that time.

Okay... I thought that it will be easier to have it done in generic 
code, if You don't
think so, then I give up and we will add it in all drivers requiring 
such memory regions.

What about patch 3/4 and 4/4? Would it be possible to have your ack to 
get them merged?
Right now patch 4/4 depends on changes from akpm tree, so it will be 
best to merge them
to akpm tree.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
