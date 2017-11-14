From: Noel.Vellemans@visionBMS.com (Vellemans, Noel)
Date: Tue, 14 Nov 2017 10:29:51 +0000
Subject: DryIce , RTC not working on imx53.
In-Reply-To: <CAOMZO5BqhhFMRByY+cHXcqmUiLVVngYHvjmTcNJP8M08ew8xnw@mail.gmail.com>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
 <20171113161522.2kq7un7gl5vg4qlq@piout.net>
 <CAOMZO5Bi5PcuGiVRZykw9Zp-ysHmHzThhwNai-cqy3HRTUKQAg@mail.gmail.com>
 <CAOMZO5AOAo8OU86CrneFeWuu2ti1sea9843UQ16=7AyU5-B11Q@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52F4BE@NT-Mail07.beckhoff.com>
 <D24E577EA1E37B4788A3BFBC418F14A707646377@wetsrvex01.loepfe.com>
 <CAOMZO5BqhhFMRByY+cHXcqmUiLVVngYHvjmTcNJP8M08ew8xnw@mail.gmail.com>
Message-ID: <D24E577EA1E37B4788A3BFBC418F14A707646790@wetsrvex01.loepfe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio

It's been a while... ( but I'm quite sure), if you look closely at the register defines ( into the DRYICE-driver-code) then you will notice... that SOME registers offsets are correct , but others are not matching the INTERNAL rtc of the IMX53.

When I noticed that ( I skipped RTC driver functionality, under release pressure, I had still many items to test on those kernel , and I was under release pressure.. so I removed RTC for the time being.)

{ you can get basic RTC , timer only , no alarms/events working... by commenting a lot of things out,  but .. I decided to solve this later the correct way,  when I find some time  ( and to report back when solved, didn't want to bother many people, or otherwise said didn't want make too many noise .... ( because rtc is not critical in my application ) }

This driver will not work for the INTERNAL-RTC ( rtc into the IMX53), and will never have worked, I can confirm this, it might have worked for some other variant of the RTC, but it will not do what we all expected for the RTC located into IMX53!


Regards
Noel


PS: Just for info,  at this time I'm investigating a NOT booting problem .. and .. it?s a hard one ( keeps me busy for some day's already ... let's say in a 500 boots there is one issue where the 'kernel' locks-up in a very very early stage.. (into the first mili-sec of the boot it hangs, some-where around IRQ-initialization .. all blocks , before CPU-identification... no clue yet where exactly..!)
{ it's only happening in latest kernels 4.4.x / 4.1x.x , older 2.6.35 do not suffer this none boot behavior ( on the same hardware) , so .. digging / debugging / printing.. :-) at this time }


_______________________
Noel Vellemans
BMS bvba

-----Original Message-----
From: Fabio Estevam [mailto:festevam at gmail.com] 
Sent: Tuesday, November 14, 2017 11:13 AM
To: Vellemans, Noel
Cc: Patrick Br?nn; Alexandre Belloni; linux-arm-kernel at lists.infradead.org; linux-rtc at vger.kernel.org
Subject: Re: DryIce , RTC not working on imx53.

Hi Noel,

On Tue, Nov 14, 2017 at 4:40 AM, Vellemans, Noel <Noel.Vellemans@visionbms.com> wrote:
> HI all,
>
> I've been digging a while in the DryIce code (some time ago, it was in a hurry because I needed to release).
>
> I finally ended up by NOT using the DryIce code , for the IMX53 ( 
> internal RTC)
>
> If I recall correctly , this is not the correct driver for the 
> Internal IMX53 RTC, ( for example the register BASE-Addresses / 
> offsets are not correct..) resulting in all kind of strange behavior, 
> depending on your situational use-cases:-(

Could you clarify about this? Which base address or offsets are not correct?
