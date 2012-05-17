From: robherring2@gmail.com (Rob Herring)
Date: Thu, 17 May 2012 18:57:48 -0500
Subject: [PATCH v2 0/9] support dt for mmp2
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <4FB5907C.9080105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2012 07:30 AM, Haojian Zhuang wrote:
> v2:
> 1. remove MACH_MMP_LEGACY & MACH_MMP2_LEGACY
> 2. use irq.c to replace irq-pxa168.c & irq-mmp2.c
> 3. Avoid to use CONFIG_OF in entry-macro.S
> 

I think you should combine all the DT board files in this series into 1
DT board file. The only diff I can see between the files is auxdata and
board strings. You don't have any platform_data for the auxdata, so I'm
guessing you are using it for clkdev lookup. You can instead simply add
addition clkdev lookup names for the DT device names. Any other reason
for needing the old device name is pretty much wrong.

Rob
