From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 5 Mar 2013 15:08:45 -0800
Subject: [PATCH v3 -next 5/5] Kconfig: Make x86 and arm kernels default
 to the LZ4-compressed
In-Reply-To: <5135DF44.2040806@openwrt.org>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
 <1362484056-9778-6-git-send-email-kyungsik.lee@lge.com>
 <5135DF44.2040806@openwrt.org>
Message-ID: <20130305150845.0d19a2875d39dac5d03b4b62@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 Mar 2013 13:04:20 +0100 Florian Fainelli <florian@openwrt.org> wrote:

> Hello,
> 
> On 03/05/2013 12:47 PM, Kyungsik Lee wrote:
> > This patch makes x86 and arm kernels default to the LZ4-compressed
> > to test new LZ4 code in the linux-next. This is requested by
> > Andrew Morton.
> 
> I do not think making this the default is good idea, because the lz4demo 
> utility that you need to actually compress the kernel (used in patch 2) 
> is not installed nor available by default on most systems, while gzip 
> is.

Yes, that's a showstopper even for linux-next.  What a shame.

It means this code will walk into mainline with practically zero
third-party testing.  Oh well, the risk is minor.  If it breaks, people
can switch back to gzip easily enough.
