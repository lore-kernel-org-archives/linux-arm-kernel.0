From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 06 Mar 2013 10:57:52 +0100
Subject: [PATCH v3 -next 5/5] Kconfig: Make x86 and arm kernels default
 to the LZ4-compressed
In-Reply-To: <20130305150845.0d19a2875d39dac5d03b4b62@linux-foundation.org>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
 <1362484056-9778-6-git-send-email-kyungsik.lee@lge.com>
 <5135DF44.2040806@openwrt.org>
 <20130305150845.0d19a2875d39dac5d03b4b62@linux-foundation.org>
Message-ID: <51371320.6000002@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2013 12:08 AM, Andrew Morton wrote:
> On Tue, 05 Mar 2013 13:04:20 +0100 Florian Fainelli <florian@openwrt.org> wrote:
>
>> Hello,
>>
>> On 03/05/2013 12:47 PM, Kyungsik Lee wrote:
>>> This patch makes x86 and arm kernels default to the LZ4-compressed
>>> to test new LZ4 code in the linux-next. This is requested by
>>> Andrew Morton.
>>
>> I do not think making this the default is good idea, because the lz4demo
>> utility that you need to actually compress the kernel (used in patch 2)
>> is not installed nor available by default on most systems, while gzip
>> is.
>
> Yes, that's a showstopper even for linux-next.  What a shame.
>
> It means this code will walk into mainline with practically zero
> third-party testing.  Oh well, the risk is minor.  If it breaks, people
> can switch back to gzip easily enough.

If we want to have more coverage, how about importing the lz4demo 
utility source code to tools/lz4/, and change scripts/Makefile.lib to 
point at it? Once the lz4 utilities have reached a broader audience and 
are available with most distributions, we could revert back to assuming 
this utility can be found in PATH.
--
Florian
