From: nkaje@codeaurora.org (Naveen Kaje)
Date: Thu, 19 May 2016 15:16:49 -0600
Subject: [PATCH v2 2/2] i2c: qup: support SMBus block read
In-Reply-To: <573E205C.9080701@codeaurora.org>
References: <1463006736-24652-1-git-send-email-nkaje@codeaurora.org>
 <1463006736-24652-2-git-send-email-nkaje@codeaurora.org>
 <000d01d1b0d3$d70e1f30$852a5d90$@codeaurora.org>
 <757c18e2-562a-9f43-0fb6-ab3e7ac3af88@codeaurora.org>
 <573E205C.9080701@codeaurora.org>
Message-ID: <1d96dfb6-9f0e-14ee-7f75-4c20fd98b183@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur, Sricharan,

On 5/19/2016 2:21 PM, Timur Tabi wrote:
> Naveen Kaje wrote:
>>>>
>>>> +        tags[len++] = QUP_TAG_V2_DATARD;
>>>> +        /* 0 implies 256 bytes */
>>>> +        if (data_len == QUP_READ_LIMIT)
>>>> +            tags[len++] = 0;
>>>> +        else
>>>> +            tags[len++] = data_len;
>>>> +    }
>>>         Even data_len will always be '1' right ?
>> Yes, but here preferably we use a variable than a number without a 
>> context.
>
> Actually, I would say the opposite.  I would rather see a constant 
> with a comment explaining it, than a variable that we know will always 
> contain only one number.
>
Ok, got it. Will be fixed in V3.
Thanks,
Naveen
