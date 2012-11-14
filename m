From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 14 Nov 2012 15:35:39 +0000
Subject: Decoding the PTM traces
In-Reply-To: <CAKZGPAP_GQh4xCXamsBOUjkfSk=Hvm96dYQD7qCbjpNWtox+tw@mail.gmail.com>
References: <CAKZGPAN-DEFD-X4az0O06ngjwdFAyrdowQ57QvtDpe8axZiwTg@mail.gmail.com>
 <50A3B18D.60907@arm.com>
 <CAKZGPAP_GQh4xCXamsBOUjkfSk=Hvm96dYQD7qCbjpNWtox+tw@mail.gmail.com>
Message-ID: <50A3BA4B.3080804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/12 15:13, Arun KS wrote:
> Hello Punit,
>
> On Wed, Nov 14, 2012 at 8:28 PM, Punit Agrawal <punit.agrawal@arm.com> wrote:
>> Hi Arun,
>>
>> You can think of the trace in the ETB as the raw stream resulting from
>> the multiplexing of different trace streams. So to get to the PTM trace
>> you'll first have to de-multiplex the stream, and then decode the stream
>> based on the source - in this case PTM.
>>
>> The format of the data stored in the ETB is described in the ETM TRM
>> Section 9.6
>> (http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0314h/Bgbhhidd.html).
>> The decoding should give you a trace stream for each active trace
>> source. The ATBID can be used to de-multiplex multiple sources, e.g.,
>> the two PTMs associated with the two A9s.
After sending the previous email, I had a quick look at etm.c and
noticed that it configures the ETB formatter to run in "Bypass" mode,
i.e., it doesn't introduce any formatting into the trace stream.
>>
>> The PTM stream can then be decoded using the Program Flow Trace Protocol
>> described in Program Flow Trace Architecture Specification Section 4
>> (http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ihi0035b/Chddbbdf.html).
> So do you mean that there is no open source tool which decodes this as
> of now and I have to write one?
I don't know of any open source tool to decode PTM trace.

But in light of the above finding, decoding only PTM trace should give
you the information you are after.

Hope that makes it a little bit easier.

Punit
>> Out of curiosity, may I ask what are you trying to do?
> The main intention is to debug freeze issues using PTM traces.
> When a device is in freeze, my intention is to  collect PTM traces
> from ETB and decode.
> So that I ll get traces of last few branches and exceptions.
>
> Thanks,
> Arun
>
>> Hope this helps. Feel free to ask for clarification.
>>
>> Cheers,
>> Punit
>>
>>
>>
>>
>> On 14/11/12 14:04, Arun KS wrote:
>>> Hello,
>>>
>>> I m trying to capture and decode PTM trace from Cortex A9 dual core.
>>>
>>> I m successful  in configuring the driver(arch/arm/kernel/etm.c) and
>>> setting the funnel to get data in ETB.
>>> But I don't know how to decode these traces.
>>>
>>> Anyone has any pointers?
>>>
>>> Thanks,
>>> Arun
>>>
>>> _______________________________________________
>>> linaro-dev mailing list
>>> linaro-dev at lists.linaro.org
>>> http://lists.linaro.org/mailman/listinfo/linaro-dev
>>>
>>>
>>>
>>
>> -- IMPORTANT NOTICE: The contents of this email and any attachments are
>> confidential and may also be privileged. If you are not the intended
>> recipient, please notify the sender immediately and do not disclose the
>> contents to any other person, use it for any purpose, or store or copy the
>> information in any medium.  Thank you.
>>
>
>


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
