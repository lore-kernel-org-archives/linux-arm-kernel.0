From: christian@riesch.at (Christian Riesch)
Date: Thu, 30 Sep 2010 05:50:58 +0200
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <alpine.DEB.2.00.1009271035110.9258@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231238170.2962@router.home>
	<1285268380.2587.11.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009231402420.2962@router.home>
	<1285273684.2587.92.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009231533040.7522@router.home>
	<20100923223417.4ed62e5b@lxorguk.ukuu.org.uk>
	<4C9BC7CE.8020400@riesch.at>
	<alpine.DEB.2.00.1009271035110.9258@router.home>
Message-ID: <20100930055058.51095mqjao91pe88@webmail.df.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Christoph Lameter <cl@linux.com>:
> On Thu, 23 Sep 2010, Christian Riesch wrote:
>
>> > > It implies clock tuning in userspace for a potential sub microsecond
>> > > accurate clock. The clock accuracy will be limited by user space
>> > > latencies and noise. You wont be able to discipline the system clock
>> > > accurately.
>> >
>> > Noise matters, latency doesn't.
>>
>> Well put! That's why we need hardware support for PTP timestamping to reduce
>> the noise, but get along well with the clock servo that is steering  
>> the PHC in
>> user space.
>
> Even if I buy into the catch phrase above: User space is subject to noise
> that the in kernel code is not. If you do the tuning over long intervals
> then it hopefully averages out but it still causes jitter effects that
> affects the degree of accuracy (or sync) that you can reach. And the noise
> varies with the load on the system.

Yes and no. If you regard it as a control system: The latencies of the  
operating system are a dead time in the control system. The sampling  
time is quite large, one second, maybe around 100ms or 10ms in  
telecommunication applications, but that is still large compared to  
the latencies you expect to have in the operating system. Hence, this  
latencies (=dead time) can be neglected and the important thing that  
remains is the noise that you introduce in the measurements of the  
time stamps, which is therefore done in hardware.
I admit that my short statement above is not completely correct, I  
should have mentioned the rather large sampling time we are dealing  
with here.

Christian
