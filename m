From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 17 Nov 2015 16:01:21 +0800
Subject: [RESEND PATCH] drm/rockchip: import dma_buf to gem
In-Reply-To: <20151116162547.GE16848@phenom.ffwll.local>
References: <1447146717-11423-1-git-send-email-mark.yao@rock-chips.com>
 <20151116162547.GE16848@phenom.ffwll.local>
Message-ID: <564ADED1.7090208@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?11?17? 00:25, Daniel Vetter wrote:
> On Tue, Nov 10, 2015 at 05:11:57PM +0800, Mark Yao wrote:
>> >We want to display a buffer allocated by other driver, need import
>> >the buffer to gem.
> Does this work with some open-source driver/userspace or is this for the
> proprietary stack only? A bit a grey area I guess, but if it's only for
> the proprietary stack I think it shouldn't land in upstream - making sure
> it works with open-source (e.g. Xorg prime) first would be good.
> -Daniel
>
Hi Daniel
     It works on open-source with following stack:
         ion -> dma_fd  -> prime fd to handle -> drm -> vop

     ion is the android ION memory allocator, its driver at 
upstream-kernel/drivers/staging/android/ion.

     We have some application use ion on android, and want to port to 
Xorg side.

Thanks

-- 
?ark Yao
