From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 10 May 2011 11:27:34 +0100
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <F1859F4DD03040248B42AC947304D39B@subhasishg>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<201105041511.54095.arnd@arndb.de>
	<4DC163D7.9010309@grandegger.com>
	<201105041648.37199.arnd@arndb.de>
	<4DC17831.3070801@grandegger.com>
	<F1859F4DD03040248B42AC947304D39B@subhasishg>
Message-ID: <20110510112734.54160824@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 May 2011 15:41:49 +0530
"Subhasish Ghosh" <subhasish@mistralsolutions.com> wrote:

> >> 
> >> It sounds to me like the best solution would be change the firmware
> >> to lift that restriction and simply allow all IDs, in case it's not
> >> actually a hardware limitation (which sounds unlikely).
> > 
> > Yes, that would be best but they told us, that it's not possible with
> > the available hardware resources. Subhasish?
> 
> Yes, In case if we allow the ALL implementation, it hogs the CPU.
> In that case we do not need the PRU. The whole purpose of the PRU
> is to offload the processor for any such implementations. 

So the kernel presumably needs to switch between using the PRU and native
according to the number of ids being requested at the time ?

That would be roughly what we do with other things (eg IP multicast) so
that apps don't need to know all the innards
