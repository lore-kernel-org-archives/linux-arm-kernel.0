From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sat, 15 Dec 2012 06:22:14 +0900
Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Kirkwood
 SoC
In-Reply-To: <20121207235904.GA15078@obsidianresearch.com>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
 <20121207232459.GA4304@obsidianresearch.com>
 <20121207235904.GA15078@obsidianresearch.com>
Message-ID: <CABMQnVKgRWk2fHWjN7ibdOJTExT=w2mu4BoJwJEkMDZmXLd4fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 8, 2012 at 8:59 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Fri, Dec 07, 2012 at 04:24:59PM -0700, Jason Gunthorpe wrote:
>> On Sat, Dec 08, 2012 at 08:15:50AM +0900, Nobuhiro Iwamatsu wrote:
>> > Some kirkwood SoC has thermal sensor.
>> > This patch adds support for 88F6282 and 88F6283.
>>
>> Thanks! I was just about to write this.. Looks good here.
>
> Ah, looking closer:
>
> $ cat /sys/class/thermal/thermal_zone0/temp
> 37
>
> That should be 37000, the value out of the driver should be in
> milli-Celsius.
>
> I'd use this equation instead:
>
>         *temp = ((322 - reg) * 10000 * 1000) / 13625;
>

OK, I will fix this.
Thanks for your review.

Best regards,
  Nobuhiro
-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
