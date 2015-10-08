From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 8 Oct 2015 09:32:40 +0100
Subject: [linux-sunxi] Re: [PATCH v2] ARM: dts: sunxi: Add regulators for
 LeMaker BananaPi
In-Reply-To: <jwvegh6d60k.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
 <20150818153631.GH2547@lukather>
 <CAMAWPa-Q7o+Ys2FjhLZt6Nwq=Ja6TTdWFDZFTCYLkoLGjpLpxw@mail.gmail.com>
 <20151005173957.B1BD16C8150E@dd34104.kasserver.com>
 <7hzizu924y.fsf@deeprootsystems.com>
 <20151007154918.D6F856C800D4@dd34104.kasserver.com>
 <jwvegh6d60k.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
Message-ID: <56162A28.8000104@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/07/2015 05:01 PM, Stefan Monnier wrote:
>> @Maxime: How should we handle this? In its current form, the patch applies
>> only to the BananaPi dts by overriding the inherited opp from the SoC dtsi.
>> In an earlier discussion, it was said that this can be done, even though it
>> might not be the most elegant approach. But then again, I think it
>> shouldn't be necessary to change the opp in the sun7i-a20.dtsi for all A20
>> boards since this is - to my knowledge - the first and only report that an
>> A20 board has stability issues at the lower voltages (although not too many
>> boards use voltage scaling yet).
>
> IIUC this setting doesn't affect signals external to the A20, so it
> seems like it should be board-agnostic.

This setting configures the voltage at the pmic output pin, not at the SoC
power-input pins. And how much of the voltage actually makes it from the pmic
to the SoC definitely is board-specific. So we are going to need board-specific
opp-s in some cases (like this one for example).

Regards,

Hans
