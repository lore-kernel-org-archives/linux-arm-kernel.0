From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 21:08:03 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150311174618.GE8656@n2100.arm.linux.org.uk>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com> <55007ADD.6080505@list.ru>
 <20150311174618.GE8656@n2100.arm.linux.org.uk>
Message-ID: <55008483.8050603@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 20:46, Russell King - ARM Linux ?????:
> On Wed, Mar 11, 2015 at 08:26:53PM +0300, Stas Sergeev wrote:
>> Hello Thomas, thanks for that info!
>>
>> Is there a quick way to test that?
>> I used memmap=0x20000000$0xe0000000 but nothing changed...
> Use mem=0xe0000000 instead.  memmap= isn't supported on ARM.

mem=0xc0000000 seems to work!
0xd0000000 or 0xe0000000 do not.
OK, so 3Gb instead of 8... but at least it boots! :)
