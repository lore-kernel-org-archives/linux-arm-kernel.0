From: yasushi.asano@jp.fujitsu.com (Asano, Yasushi)
Date: Tue, 4 Dec 2012 12:57:57 +0000
Subject: About the workaround for the 484863 L220 erratum
Message-ID: <4AE7B88EC8BA74469869BB7EEB7D66671BCA3685@g01jpexmbyt23>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am looking for a workaround for the 484863 L220 erratum. 
"484863: The Cache Sync operation does not guarantee that the Eviction Buffer is empty"

Then I found a patch as below.
http://www.linux-arm.org/git?p=linux-2.6-stable.git;a=commitdiff;h=61f0ab1658f41f34c1910848063c565095a47864
Though It seems to need should correct this probrem, this patch has not been marged into the mainline yet.

v3.6.9?arch/arm/include/asm/io.h
#define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(v),c)

Could you please tell me if you know the reason why it does not get into the mainline.
Thank you for your time and assistance regarding this matter.
