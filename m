From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 5 Dec 2012 14:05:47 +0530
Subject: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C14311FB29D@DFLE08.ent.ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-5-git-send-email-rtivy@ti.com>	<50AB76FA.1050505@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F952B@DFLE08.ent.ti.com>
 <50B88F7C.5000705@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FAC29@DFLE08.ent.ti.com>
 <50BCBA26.4070608@ti.com> <50BD07D8.5000305@ti.com> <50BD90F6.4080102@ti.com>
 <50BE0E54.5060607@ti.com> <50BE2115.4000606@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FB29D@DFLE08.ent.ti.com>
Message-ID: <50BF0763.8000304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

adding back the ARM list.

On 12/5/2012 7:53 AM, Tivy, Robert wrote:
>> -----Original Message-----
>> From: davinci-linux-open-source-bounces at linux.davincidsp.com
>> [mailto:davinci-linux-open-source-bounces at linux.davincidsp.com] On
>> Behalf Of Karicheri, Muralidharan
>> Sent: Tuesday, December 04, 2012 8:13 AM
>> To: davinci-linux-open-source at linux.davincidsp.com
>> Subject: Re: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
>> OMAP-L138 DSP
>>
>> On 12/04/2012 09:53 AM, Murali Karicheri wrote:
>>>>
>>>>
>>> I believe this is addressing the same issue. This is a DT based
>>> solution, which I believe should add a framework and enhance it to
>>> support DT.
>> Forgot to paste the link. Here we go
>>
>> https://patchwork.kernel.org/patch/1635051/
>>
> 
> Thanks Murali, very interesting.
> 
> The thread in your link above mentions omap_hwmod at the end, and I've been looking at how that's handled but it's quite complex.  Would a similar solution (davinci_hwmod) be a good approach?

Um, no. I don't think the thread is proposing hwmod kind of
implementation for each machine that implements the (to be proposed)
reset API. Mike is just asking to have a look at omap hwmod to see how
it handles device resets for an inspiration on how the proposed API can
work. The final API will generic with machine specific implementation
for each machine that implements it.

OMAP created HWMOD to handle the complexities of that chip, there is no
need to replicate that in DaVinci.

The link is definitely interesting and exactly what we were looking for.
It will be better to continue the discussion on that thread there so all
interested parties are on a single thread.

Thanks,
Sekhar
