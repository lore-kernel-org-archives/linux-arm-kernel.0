From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 17:37:12 +0200
Subject: [PATCH 1/2 RESEND] ARM: prima2: move to use REGMAP APIs for
 rtciobrg
In-Reply-To: <1429012556-14041-1-git-send-email-21cnbao@gmail.com>
References: <1429012556-14041-1-git-send-email-21cnbao@gmail.com>
Message-ID: <2891950.ACQLuhXHau@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 11:55:55 Barry Song wrote:
> From: Guo Zeng <Guo.Zeng@csr.com>
> 
> all devices behind rtciobrg needs a special way to access. currently they
> are using a platform-specific API.
> this patch moves to REGMAP, then clients can use regmap APIs to read/write.
> for the moment, old APIs are still kept, once all clients move to regmap,
> old APIs will be dropped.
> 
> this patch also does minor clean for comments, authors statement.
> 
> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> 

I've finally managed to take a look at the two patches.

For this one, the implementation looks ok in principle, though I wonder
if you would be able to move the code to a more appropriate location,
possibly drivers/bus, drivers/soc or into the rtc-sirfsoc driver.

What devices specifically are abstracted by the rtciobrg?

	Arnd
