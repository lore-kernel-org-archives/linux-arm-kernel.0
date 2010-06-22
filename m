From: adrian.wenl@gmail.com (Lei Wen)
Date: Tue, 22 Jun 2010 16:20:29 +0800
Subject: [PATCH 07/25] pxa3xx_nand: mtd scan id process could be defined
	by driver itself
In-Reply-To: <AANLkTimnaBO_Zb0UvPZYzmQNmqJafTv1gWV8KQm_LwC3@mail.gmail.com>
References: <AANLkTilY1gnS_jwZ_xPKhchTLR5cWj7FEla1V76OuMVK@mail.gmail.com>
	<AANLkTimnaBO_Zb0UvPZYzmQNmqJafTv1gWV8KQm_LwC3@mail.gmail.com>
Message-ID: <AANLkTimPAVPFX3vhYhkCBUCXk6-EEirsNBtD5R3xW8Yt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 2:58 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Jun 18, 2010 at 1:34 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> From d2958ecbec5d0b7f7aee311fd3e87ed1a858864d Mon Sep 17 00:00:00 2001
>> From: Lei Wen <leiwen@marvell.com>
>> Date: Wed, 2 Jun 2010 21:55:51 +0800
>> Subject: [PATCH 07/25] pxa3xx_nand: mtd scan id process could be
>> defined by driver itself
>>
>> Different NAND driver may require its unique detection. For pxa3xx_nand,
>> it use its self id database to get the necessary info.
>
> I believe I get the central point of this patch: to have a specific
> pxa3xx_nand_scan()
> instead of using the generic nand_scan(). This point is good, yet I
> found it extremely
> difficult to read the patch. Like those chip->xxxx assignment, is that
> also part of this
> patch, I strongly recommend to remove irrelevant changes into separate patches.
>

That is also the part of this patch...
-       this->read_word         = pxa3xx_nand_read_word;
+       chip->read_word         = pxa3xx_nand_read_word;
Just use "chip" to take place of "this"...

Best regards,
Lei
