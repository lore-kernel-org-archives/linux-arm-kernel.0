From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Fri, 25 Mar 2011 10:53:08 +0100
Subject: IRQ handler under load - slow response
In-Reply-To: <AANLkTikQhKz73sv1so2EepdeP5Nh6ZiLJ4+MKcNkt+u=@mail.gmail.com>
References: <AANLkTinTCfrPPwP6ZnWZTWW8vmR4=Uaw+OmHK7b99-9g@mail.gmail.com>
	<20110309152252.GB333@e-circ.dyndns.org>
	<AANLkTikCSE3xOYsAnSJQQnW9iTrwbvoscU8hikkewGh6@mail.gmail.com>
	<20110314144715.GH333@e-circ.dyndns.org>
	<AANLkTinmQ0seioxSPaj8eqHAwuDpuDSCSmg=BTYHbrkT@mail.gmail.com>
	<20110324144518.GA27661@e-circ.dyndns.org>
	<AANLkTikQhKz73sv1so2EepdeP5Nh6ZiLJ4+MKcNkt+u=@mail.gmail.com>
Message-ID: <20110325095308.GB349@e-circ.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2011 at 09:46:43AM +0100, Arno Steffen wrote:
> 2011/3/24 Kurt Van Dijck <kurt.van.dijck@eia.be>:
> > On Thu, Mar 24, 2011 at 12:56:48PM +0100, Arno Steffen wrote:
> >> 2011/3/14 Kurt Van Dijck <kurt.van.dijck@eia.be>:
> >> > On Mon, Mar 14, 2011 at 02:26:35PM +0100, Arno Steffen wrote:
> 
> I get it working with your help. I see now threads for every IRQ I
> anounce to the system.
Good news. I'm in fact a bit curious to the results...
> Nevertheless it doesn't change the behaviour,
> even after increasing their prio. My assumption is: The kernel IRQs
> threads are processed fast, I do have the trouble on the user side of
> the IRQ handler.
> 
> The best performance I get, if all processes on my device are running
> in policy OTHER.
Just to update my memory: I think threaded-irq will give:
* less peak perfomance
* less average performance
* better 'worst' performance
ie. There should be much less jitter in the performance measurement.
> As soon as my code is running in FIFO or RR I have
> problems. If the IRQs-thread has higher priority it works better, but
> is far away from reliability of OTHER policy.
That's less good news.
I suppose you have enabled all relevant RT & preemptive options.
Then I'm out of ideas too.
> This is in opposite to
> all what I know about scheduling policies.
Ack.
> 
> Best regards
> Arno

Regards,
Kurt
