From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 27 Jul 2015 14:54:51 +0200
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <20150727123653.36C046C8007E@dd34104.kasserver.com>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de><55B5E6DB.8020009@redhat.com>
 <20150727123653.36C046C8007E@dd34104.kasserver.com>
Message-ID: <55B62A1B.6030601@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-07-15 14:36, public_timo.s at silentcreek.de wrote:
> Hi again,
>
> one more thing...
>
> Hans de Goede schrieb am 27.07.2015 10:07:
>> IMHO we should just stick with the standard operating points unless we know
>> that there are stability issues with them (such as e.g. on the A10 OlinuxIno
>> Lime).
>
> If we stick to the standard operating points, shouldn't we honor their voltages
> as well? If we set the minimum voltage for dcdc2 to 1.0V (as you did) or 1.05V
> (as I did), this means that the lowest operating point of 144MHz at 0.9V defined
> in sun7i-a20.dtsi (and with my definition the 312MHz opp as well) will not be
> available because cpufreq-dt simply ignores operating points that aren't within
> the set voltage range for that regulator.

Ah, good point. I don't know what is the right thing todo here.

ChenYu (in the CC), since you did most of the original work here, do
you know why we have an op at 0.9 volt, but none of our boards allow the
voltage to go that low in the regulator settings ?

Regards,

Hans
