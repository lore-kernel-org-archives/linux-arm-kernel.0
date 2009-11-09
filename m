From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 9 Nov 2009 11:39:30 +0800
Subject: [PATCH 3/6] pxa: fix pxa168 lcd controller vsync/hsync timing
	error
In-Reply-To: <7c34ac520911041815k6555e209r4039ae9f97c9ebca@mail.gmail.com>
References: <7c34ac520911022245x7f002a7at846a835dfded550c@mail.gmail.com>
	<f17812d70911032320k379dc7laab1979a3b452969@mail.gmail.com>
	<7c34ac520911041815k6555e209r4039ae9f97c9ebca@mail.gmail.com>
Message-ID: <f17812d70911081939nf30b893vc8a9b3cf821fc78@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Could you please help double check this? My understanding is
>> FB_SYNC_VERT_HIGH_ACT means it's a positive pulse covering all the
>> valid HSYNCs, and a rising edge of VSYNC means a start of the frame.
>>
>> However, CFG_INV_VSYNC is '1' means the opposite.
>>
>
> My understanding is that high active means high level trigger new
> frame/line. Below page support my point if it is not wrong.
>
> http://www.arcadecollecting.com/info/Sync_fixing.txt
>

Tried to find the specific diagram in the spec on what CFG_INV_* means
but failed, can you help verified this with an oscilloscope and let know
the result? This is a fix then, and I'd like it to get into .32, sorry for late
reply.
