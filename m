From: jenskuske@gmail.com (Jens Kuske)
Date: Thu, 28 Jan 2016 14:16:26 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <56A9CE3D.4020906@redhat.com>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr> <56A8D5E5.30701@gmail.com>
 <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
 <56A9CE3D.4020906@redhat.com>
Message-ID: <56AA14AA.4070502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 09:15, Hans de Goede wrote:
> Hi,
> 
> On 27-01-16 20:02, Jean-Francois Moine wrote:
>> On Wed, 27 Jan 2016 19:16:42 +0100
>> Hans de Goede <hdegoede@redhat.com> wrote:
>>
>>>> To be sure, I generated a pure 4.5-rc1 kernel. Same result: no UART.
>>>> Maybe... one more information: I am using Allwinner's u-boot.
>>>
>>> Could be that that is the culprit, why are you not using upstream u-boot?
>>> upstream u-boot has H3 and orangepi-pc support now.
>>
>> Yes, but using the upstream u-boot may hide the clock problem.
> 
> I agree that that could be the case. Would be interesting to figure out
> what exactly is needed to get the upstream kernel to work properly
> with allwinner's u-boot.

Hi,

after figuring out how to boot a devicetree kernel with allwinner's
u-boot I only had to add the mandatory
	
	clock-frequency = <24000000>;
	arm,cpu-registers-not-fw-configured;

to the timer node and v4.5-rc1 booted successfully. They are
intentionally left out in the official dt, because documentation says
one should prefer to fix the firmware -> mainline u-boot
No problems with clocks or uart here.

Jens
