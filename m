From: lho@apm.com (Loc Ho)
Date: Mon, 4 May 2015 16:39:36 -0700
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAL_JsqLyyBCd3DcwjWw57XCQ0fEWHXo_0dkWeBo=TVDoXM_zhQ@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <7128860.xHITr0VFap@wuerfel> <20150430094134.GD3488@pd.tnic>
 <10227049.9i19zDi2y3@wuerfel> <20150430130028.GF3488@pd.tnic>
 <CAPw-ZTnuyB2ne1C2-38qAxM_ANwdr9nuCYUMj=aTx7c90sVg+Q@mail.gmail.com>
 <20150430171846.GJ3488@pd.tnic>
 <CAPw-ZTksYNDE2zVD=ZjGzpKfXQN8KgW85ZnHoQ2eVmSGdSdMOw@mail.gmail.com>
 <CAL_JsqL7emqq=bSaWSi_0G5qSJqO+nVH_JH7VY+ynbrHhaSf_g@mail.gmail.com>
 <CAPw-ZTnNEiTA-MJthY04yCrc9RdZOUFaNjzBHFV1fWzkBqRCyQ@mail.gmail.com>
 <CAL_JsqLyyBCd3DcwjWw57XCQ0fEWHXo_0dkWeBo=TVDoXM_zhQ@mail.gmail.com>
Message-ID: <CAPw-ZT=YH8faa4_iWfpwOkbxeVDeDNqpJqnOcfnov3s1ianq1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 4, 2015 at 3:36 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, May 1, 2015 at 2:59 PM, Loc Ho <lho@apm.com> wrote:
>> Hi Rob,
>>
>>>>>> I think we should first agreed on the DT binding and let's not worry
>>>>>> about APEI. Then, whether we have one file or multiple file. Again,
>>>>>> the HW consist of:
>>>>>>
>>>>>> 1. One top level interrupt and status registers
>>>
>>> For these registers, are there ECC specific functions here or just
>>> normal interrupt control/status bits (mask/unmask/status)? Assuming
>>> the later, then you should make this block an interrupt-controller.
>>> Then this is the interrupt-parent for the rest of the blocks.
>>>
>>
>> This is the only item remain before I generate an patch with just the
>> memory controller. Most of the code that I see are actually an
>> interrupt controller HW. As it is just an interrupt mask and status
>> registers, is there an example in Linux that I can model after? Also,
>> I am not quite convince as to why we can't just share the interrupt
>> and request it by each memory controller?
>
> Pretty much anything that calls irq_set_chained_handler. If you don't
> need to touch the shared registers and can set them up once at boot
> time, then you could just do shared irq handlers. But if you have to
> clear the interrupt within the PCP, you need a demuxer.
>

Thanks Rob. I look through the entire driver. Interrupts are cleared
at the source. Therefore, the next version will just register for the
shared interrupt as it is currently.

-Loc
