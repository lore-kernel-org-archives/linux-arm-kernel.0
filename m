From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 06 Aug 2013 17:07:21 +0200
Subject: [PATCH v4 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <CAL_JsqK7FNeqbx2DFHou5xeU08L4Stn+NrHUmFjap_A1pEq9JQ@mail.gmail.com>
References: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
 <1375275119-12787-4-git-send-email-m.szyprowski@samsung.com>
 <CAL_JsqK7FNeqbx2DFHou5xeU08L4Stn+NrHUmFjap_A1pEq9JQ@mail.gmail.com>
Message-ID: <xa1ttxj2luxi.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06 2013, Rob Herring wrote:
>> +static void reserved_mem_release_device_from_dt(struct device *dev)
>> +{
>> +       struct reserved_mem *region = get_dma_memory_region(dev);
>> +       if (!region)
>> +               return;
>> +       if (!region->cma)
>
> if (region && !region->cma)

!region case is handled two lines above, so no need to check if region
is not null.

>> +               dma_release_declared_memory(dev);
>> +}

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130806/403761e4/attachment.sig>
