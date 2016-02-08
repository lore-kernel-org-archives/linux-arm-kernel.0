From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 8 Feb 2016 11:55:44 +0100
Subject: [PATCH] clk: meson: Fix meson_clk_register_clks() signature type
 mismatch
In-Reply-To: <CAOQ7t2YwHa7cJdqv4m8rPx50ZnFZJJzcU2AjtE=Q2AYEAf84hg@mail.gmail.com>
References: <1454879583-27036-1-git-send-email-afaerber@suse.de>
 <CAOQ7t2YwHa7cJdqv4m8rPx50ZnFZJJzcU2AjtE=Q2AYEAf84hg@mail.gmail.com>
Message-ID: <56B87430.3040804@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.02.2016 um 09:34 schrieb Carlo Caione:
> On Sun, Feb 7, 2016 at 10:13 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> As preparation for arm64 based mesongxbb, which pulls in this code once
>> enabling ARCH_MESON, fix a size_t vs. unsigned int type mismatch.
>> The loop uses a local unsigned int variable, so adopt that type,
>> matching the header.
>>
>> Fixes: 7a29a869434e ("clk: meson: Add support for Meson clock controller")
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  drivers/clk/meson/clkc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
[...]
> Also please, CC linux-meson at googlegroups.com on meson related patches.

I used scripts/get_maintainer.pl --nogit-fallback on next-20160111. :)

If there is no in-flight patch I've missed, I can send a patch against
MAINTAINERS to update it with that list address.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
