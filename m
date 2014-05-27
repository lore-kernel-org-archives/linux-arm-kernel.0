From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 27 May 2014 13:23:40 -0700
Subject: [PATCH v1] of/irq: do irq resolution in platform_get_irq_byname()
In-Reply-To: <20140523080333.66720C4176E@trevor.secretlab.ca>
References: <1400582523-22684-1-git-send-email-grygorii.strashko@ti.com>
 <20140523080333.66720C4176E@trevor.secretlab.ca>
Message-ID: <CAGa+x85mOHtNAj-UHgK2_z8zWAF=qwFcRcUgHTR-byNiX7heHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 1:03 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Tue, 20 May 2014 13:42:02 +0300, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>> The commit 9ec36cafe43bf835f8f29273597a5b0cbc8267ef
>> "of/irq: do irq resolution in platform_get_irq" from Rob Herring -
>> moves resolving of the interrupt resources in platform_get_irq().
>> But this solution isn't complete because platform_get_irq_byname()
>> need to be modified the same way.
>>
>> Hence, fix it by adding interrupt resolution code at the
>> platform_get_irq_byname() function too.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>
> Applied, Thanks.

As of next-20150526, the ST u8500 Snowball board has been failing boot
in linux-next, and was bisected down to this patch (commit
ad69674e73a1 in -next).   Full boot failure attached.

I have not dug any deeper, but can confirm that next-20140526 with
this patch reverted boots again on the snowball board.

Kevin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: boot-ste-snowball.log
Type: text/x-log
Size: 41500 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/c1b80b03/attachment-0001.bin>
