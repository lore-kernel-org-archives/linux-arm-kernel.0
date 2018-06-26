From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Jun 2018 11:17:30 +0800
Subject: [PATCH 2/2] arm64: allwinner: a64: allow laptops to wake up from
 lid
In-Reply-To: <20180625170913.p335obgr3rfa4skt@flea>
References: <20180622160631.8578-1-icenowy@aosc.io>
 <20180622160631.8578-2-icenowy@aosc.io>
 <20180625170913.p335obgr3rfa4skt@flea>
Message-ID: <CAGb2v65HJKm3UhA1bPZxg7+KL_FAHO+LDx4ijzXasS-K0UGUXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 1:09 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Sat, Jun 23, 2018 at 12:06:31AM +0800, Icenowy Zheng wrote:
>> Currently all ARM kernels will have s2idle enabled if CONFIG_SUSPEND is
>> present. In this case if the lid is closed, systemd-logind will enter
>> s2idle mode by default; however there's no possible wakeup source
>> defined, so the system will enter a forever idle.
>>
>> Add the lid itself as a wakeup source, thus the system can wakeup when
>> the lid is opened.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
> Applied both, thanks!
> Maxime

Icenowy, could you also look into having the power button as a wakeup source?
It has no device node, so you might have to look at how to implement it in
the driver.

ChenYu
