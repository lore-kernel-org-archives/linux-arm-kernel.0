From: Noel.Vellemans@visionBMS.com (Vellemans, Noel)
Date: Tue, 14 Nov 2017 12:56:30 +0000
Subject: DryIce , RTC not working on imx53.
In-Reply-To: <201711141343.15309.jbe@pengutronix.de>
References: <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <CAOMZO5CdGAqBkBQ5DdphzNr-tB5r7Sj9jBAhFTFPNezTEjJOMg@mail.gmail.com>
 <20171114105517.74ycmwcjsab7xp2j@piout.net>
 <201711141343.15309.jbe@pengutronix.de>
Message-ID: <D24E577EA1E37B4788A3BFBC418F14A707646BEA@wetsrvex01.loepfe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all, 

Juergen It won't work ( as it is) , registers are not on the correct offsets and some bits are not on the same positions ( for the IMX53)
This driver will not work for the INTERNAL-RTC ( rtc into the IMX53), and will never have worked ( on IMX53). 
I can confirm, it might work for some other variant of the RTC, but it will not do what we all expected for the RTC located into IMX53!

( not sure my previous mail got to the destination)

Best Regards
Noel




>>
>> > Juergen can confirm, but it seems the dryice driver was only used on
> > mx25 in mainline.
>>
>>> Ok, that would explain it.
>>
>>Yes. The development was made on an i.MX25. But currently I have an i.MX53 on my desk here and could test...
>>
>>jb

>>>
>>
>>
>>
>>-----Original Message-----
>>From: Vellemans, Noel 
>>Sent: Tuesday, November 14, 2017 11:30 AM
>>To: 'Fabio Estevam'
>>Cc: Patrick Br?nn; Alexandre Belloni; linux-arm-kernel at lists.infradead.org; linux-rtc at vger.kernel.org
>>Subject: RE: DryIce , RTC not working on imx53.
>>
>>Hi Fabio
>>
>>It's been a while... ( but I'm quite sure), if you look closely at the register defines ( into the DRYICE-driver-code) then you will notice... that SOME registers offsets are correct , but others are not matching the INTERNAL rtc of the IMX53.
>>
>>When I noticed that ( I skipped RTC driver functionality, under release pressure, I had still many items to test on those kernel , and I was under release pressure.. so I removed RTC for the time being.)
>>
>>{ you can get basic RTC , timer only , no alarms/events working... by commenting a lot of things out,  but .. I decided to solve this later the correct way,  when I find some time  ( and to report back when solved, didn't want to bother many people, or otherwise said didn't want make too many noise .... ( because rtc is not critical in my application ) }
>>
>>This driver will not work for the INTERNAL-RTC ( rtc into the IMX53), and will never have worked, I can confirm this, it might have worked for some other variant of the RTC, but it will not do what we all expected for the RTC located into IMX53!
>>
>>
>>Regards
>>Noel
>>
>>PS: Just for info,  at this time I'm investigating a NOT booting problem .. and .. it?s a hard one ( keeps me busy for some day's already ... let's say in a 500 boots there is one issue where the 'kernel' locks-up in a 
>>very very early stage.. (into the first mili-sec of the boot it hangs, some-where around IRQ-initialization .. all blocks , before CPU-identification... no clue yet where exactly..!) 
>>{ it's only happening in latest kernels 4.4.x / 4.1x.x , older 2.6.35 do not suffer this none boot behavior ( on the same hardware) , so .. digging / debugging / printing.. :-) at this time }
