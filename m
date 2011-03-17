From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 17 Mar 2011 10:07:12 -0700
Subject: reboot/kexec in 2.6.38
In-Reply-To: <20110317125839.GB21290@atrey.karlin.mff.cuni.cz> (Cyril Hrubis's
	message of "Thu, 17 Mar 2011 13:58:39 +0100")
References: <20110317064523.GA1995@ucw.cz>
	<AANLkTik1CdT4k8SJop7b-MjR27RzF7a=i7WuodNKJi+J@mail.gmail.com>
	<20110317125839.GB21290@atrey.karlin.mff.cuni.cz>
Message-ID: <m1d3lpbrr3.fsf@fess.ebiederm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cyril Hrubis <metan@ucw.cz> writes:

> Hi!
>> > I got report that ?reboot/kexec does not work in recent kernels.
>> >
>> > I tried both kexec and reboot in 2.6.38, and it worked ok. Maybe
>> > config issue?
>> 
>> I think it's config issue. Never heard of this.
>>
>
> I've seen that on my zaurus a month or two ago. When kexeced to pxa-linux-2.6
> then tried to kexec again. The last thing I've seen was Bye on the framebuffer
> console and the machine freezed.

The basic kexec code has been stable and solid for a long time so kexec
failures are almost always hardware interaction problems.

Someone not stopping dma, or someone not putting the hardware in a state
that the next kernel can figure out how to initialize it.

Eric
