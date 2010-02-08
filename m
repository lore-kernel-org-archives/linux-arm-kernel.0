From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 08 Feb 2010 13:30:42 +0200
Subject: smsc911x suspend/resume
In-Reply-To: <20100208101123.GW28972@buzzloop.caiaq.de>
References: <4B6FDC83.9090205@compulab.co.il>
	<20100208101123.GW28972@buzzloop.caiaq.de>
Message-ID: <4B6FF5E2.6060304@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack wrote:
> On Mon, Feb 08, 2010 at 11:42:27AM +0200, Mike Rapoport wrote:
>> I'm trying to make suspend/resume work on OMAP3-based system and I'm
>> encountering issues with resume of SMSC 9220 chip.
>> After resume the interface is unusable unless I do 'ifconfig eth0 down'
>> and 'ifconfig eth0 up'.
>> I would expect that 'ping <some host>' would work right after resume
>> without need to bring the interface down and up, but probably I miss
>> something.
>> Any help would be appreciated.
> 
> What happens to your supply voltages when going to suspend? When I
> implemented the code for the smsc driver, I could only test scenarios
> where AVDD remains stable during suspend. So the driver might need some
> tweaks if that assumption is not true in your case. The SMSC datasheet
> is quite comprehensive about this topic IIRC.

By AVDD you mean VDD33A?
Anyway, I have all the supplies except VDDVARIO shut down...
And the datasheet is indeed comprehensively describes chip power states
but I haven't found there anything about supplies required to stay on
during suspend...


> Also have a look at the Raumfeld device patches which use exactly this
> chip and which can suspend and resume just fine. You'll need to check
> out Eric's devel branch for that.
> 
> Daniel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
