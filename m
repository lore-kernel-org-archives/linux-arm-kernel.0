From: armando.visconti@st.com (Armando Visconti)
Date: Mon, 6 Sep 2010 09:20:48 +0200
Subject: [PATCH 2/3] plat-nomadik: Added suspend/resume support for MTU
	timer.
In-Reply-To: <AANLkTin-BqN=VKjO3rLJbh3m5OroSfkAF8urhE9Y=yR4@mail.gmail.com>
References: <1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>	<1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>	<20100902160443.GR26319@n2100.arm.linux.org.uk>	<AANLkTikTuuVGnOstk+YGq3R9pwrMT-qwkbo7CXMJ4NB6@mail.gmail.com>	<20100903114900.GA3495@morgana.i.gnudd.com>
	<AANLkTin-BqN=VKjO3rLJbh3m5OroSfkAF8urhE9Y=yR4@mail.gmail.com>
Message-ID: <4C849650.8050005@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 2010/9/3 Alessandro Rubini <rubini-list@gnudd.com>:
>   
>> [Me]
>>     
>>> Alessandro why do we kick in a prescaler if rate > (16 << 20)?
>>> Seems weird to me too when I look at it, more like it'd be
>>> if rate (1 << 20) which makes sense, if the counter will flip
>>> around 20 bits in 1 second we prescale it by 16.
>>>       
>> Your "makes sense" is as subjective as mine. But on 8815, with 2.4MHz
>> we overflow in around 1790 seconds. I feel it reasonable. If you
>> prescale we get at 150kHz, which is 6.6 usec per tick: I don't like
>> that figure too much.
>>     
>
> Ah I got it backwards, actually I was thinking along the lines
> that since (16 << 20) == (1 << 25) the latter would be more
> apropriate thats what I think makes sense, it's so binary...
> not (1 << 20) sorry for that.
>   
Sorry,

I'm not following the discussion, but just for the sake
of precision, should be

(16 << 20) == (1 << 24)

Is it right?

Sorry for intruding,
Arm
