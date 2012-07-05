From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 05 Jul 2012 12:38:51 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <20120705122050.2fbc2fe3@skate> (Thomas Petazzoni's message of
 "Thu, 5 Jul 2012 12:20:50 +0200")
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch>
 <87sjd6ikkj.fsf@lebrac.rtp-net.org> <20120705122050.2fbc2fe3@skate>
Message-ID: <87liiyijb8.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> Le Thu, 05 Jul 2012 12:11:40 +0200,
> Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> a ?crit :
>
>> > You are not the only one working in this area. Arnaud Patard said he
>> > was look at this as well. 
>> 
>> yeah, but tbh I've not made anything yet. If Thomas has already some
>> code for it, we should try to make it "generic" so as to use it on
>> armada xp and orion platforms.
>
> The MPP registers are identical on Armada XP/370 and 88F6281 (not sure
> which other SoC datasheet I should be checking). Basically, it's just a
> range of contiguous registers, with 4 bits per pin to select the
> function.


iirc, other SoCs are similar. The small exception being dove I
guess. Dove has a 3rd gpo [the gpios are output only] bank but to be
used as gpio require that a special bit is set and it's for all gpios of
this bank. You'll find this bit in the "general mpp configuration
register" if you look at the datasheet.

>
> So my pinmux driver should simply work as is for Orion as well. The
> only difference between platforms is the number of MPP pins that are
> available, but this number also varies between versions of Armada XP
> and Armada 370, so I already support this in the driver.
>

Are there some output-only gpio on armada xp/370 like on kirkwood/dove ?


Arnaud
