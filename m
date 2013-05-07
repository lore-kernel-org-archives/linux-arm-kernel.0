From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 07 May 2013 18:36:29 +0200
Subject: [PATCH 1/3] clk: mvebu: add gate ctrl for Prestera kirkwood
 variants
In-Reply-To: <518927C0.6070600@free-electrons.com>
References: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
 <1367941941-19152-2-git-send-email-valentin.longchamp@keymile.com>
 <518927C0.6070600@free-electrons.com>
Message-ID: <51892D8D.4060704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2013 06:11 PM, Gregory CLEMENT wrote:
> On 05/07/2013 05:52 PM, Valentin Longchamp wrote:
>> The kirkwood device found in the Prestera SoCs does not have all the
>> peripherals of its the usual kirkwood SoCs. There are hence missing
>> clocks in the SoCs.
>>
>> This patch registers another gate controller for the kirkwood that
>> registers only the available clocks of this kirkwood variant.
>
> Hi Valentin,
>
> Overall the patch set looks OK, however I don't understand why you need
> to declare a new gate controller. The list you delcared seemed to be
> just a subset of the Kirkwood one, why can't you use this one?
>
> Note that I am not an expert for the kirkwood hardware, so maybe I
> missed something.

I just checked my mails from late 2012 and there Valentin and I agreed,
that not the missing bits in clock gating control registers was the root
cause of km_kirkwood to hang. It was rather the phy gates (that do not/
not yet exist on DT) that caused it to hang, i.e. when accessing SATA
PHY registers.

Valentin, I am not against an extra clock-gating-ctrl for Prestera but
maybe having an kirkwood.dtsi fork without SATA and other peripherals
will also help?

And: Does DT-enabled km_kirkwood ever hang without the hack in it's
board setup? There should be no PHY gates on DT boards..

Sebastian
