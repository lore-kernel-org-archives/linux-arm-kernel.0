From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 05 Mar 2013 13:04:20 +0100
Subject: [PATCH v3 -next 5/5] Kconfig: Make x86 and arm kernels default
 to the LZ4-compressed
In-Reply-To: <1362484056-9778-6-git-send-email-kyungsik.lee@lge.com>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
 <1362484056-9778-6-git-send-email-kyungsik.lee@lge.com>
Message-ID: <5135DF44.2040806@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 03/05/2013 12:47 PM, Kyungsik Lee wrote:
> This patch makes x86 and arm kernels default to the LZ4-compressed
> to test new LZ4 code in the linux-next. This is requested by
> Andrew Morton.

I do not think making this the default is good idea, because the lz4demo 
utility that you need to actually compress the kernel (used in patch 2) 
is not installed nor available by default on most systems, while gzip 
is. Considering that such a concern was already raised in your v2 
patchset, I am surprised to see this.
--
Florian
