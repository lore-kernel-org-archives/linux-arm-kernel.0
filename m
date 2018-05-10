From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 10 May 2018 12:25:21 +0100
Subject: [PATCH v2] tty: implement led triggers
In-Reply-To: <20180510111434.GC6977@amd>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
 <20180507092710.GQ2285@localhost> <20180510111434.GC6977@amd>
Message-ID: <01dcbf5c-70a0-b067-20c3-f99e22ed4512@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/18 12:14, Pavel Machek wrote:
> Hi!
> 
>>>>> @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
>>>>>   		struct tty_buffer *head = buf->head;
>>>>>   		struct tty_buffer *next;
>>>>>   		int count;
>>>>> +		unsigned long delay = 50 /* ms */;
>>>>
>>>> Comment after the semicolon?
>>>
>>> Given that this comment is about the 50 and not the delay member, I
>>> prefer it before the ;.
>>
>> Hmm. I personally find it hard to read and can only find about 30
>> instances of this comment style (for assignments) in the kernel. And
>> arguably the comment applies equally well to the delay variable in this
>> case too.
> 
> It is not too traditional, but I believe it makes sense....
> 
> (and yes, I wish we had kernel in Rust, so we could have real units
> attached to our variables...)

Well, the variable itself could always be named "delay_ms" if it's 
really that important.

Robin.
