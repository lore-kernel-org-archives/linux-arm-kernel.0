From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 17 Jan 2014 11:00:58 +0200
Subject: [PATCH 13/15] fbdev: sh-mobile-lcdcfb: Enable driver compilation
 with COMPILE_TEST
In-Reply-To: <52CD0CBB.3070801@ti.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1542726.dq1lpTml5f@avalon> <1917257.yB7aZMXWdP@avalon>
 <52CD0CBB.3070801@ti.com>
Message-ID: <52D8F14A.7030100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2014-01-08 10:30, Tomi Valkeinen wrote:
> On 2014-01-07 17:15, Laurent Pinchart wrote:
>> On Wednesday 11 December 2013 13:51:18 Laurent Pinchart wrote:
>>> Hi Jean-Christophe and Tomi,
>>>
>>> Could you please pick this patch up for v3.14 ?
>>
>> Ping ?
> 
> Queued for 3.14.

I'll drop this patch, as it causes compile break (from kbuild test robot):

All error/warnings:

   drivers/built-in.o: In function `sh_mobile_lcdc_pan':
>> sh_mobile_lcdcfb.c:(.text+0x77373): undefined reference to
`sh_mobile_meram_cache_update'
   drivers/built-in.o: In function `sh_mobile_lcdc_start':
>> sh_mobile_lcdcfb.c:(.text+0x79320): undefined reference to
`sh_mobile_meram_cache_free'
>> sh_mobile_lcdcfb.c:(.text+0x79394): undefined reference to
`sh_mobile_meram_cache_alloc'
>> sh_mobile_lcdcfb.c:(.text+0x793d4): undefined reference to
`sh_mobile_meram_cache_update'
   drivers/built-in.o: In function `sh_mobile_lcdc_stop':
>> sh_mobile_lcdcfb.c:(.text+0x79616): undefined reference to
`sh_mobile_meram_cache_free'

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/cb1f7878/attachment.sig>
