From: b51503@freescale.com (Bai Ping)
Date: Tue, 15 Dec 2015 20:25:40 +0800
Subject: [PATCH] ARM: dts: imx: Fix the assigned-clock mismatch issue on
 imx6q/dl
In-Reply-To: <CAOMZO5BKFqMKpRiM6hV43Ko7YcGHPEChSi1GEBMzg3oGo6_Lnw@mail.gmail.com>
References: <1449648955-30835-1-git-send-email-b51503@freescale.com>
 <20151214030750.GF25756@tiger> <20151215085237.GB388@tiger>
 <CAOMZO5BKFqMKpRiM6hV43Ko7YcGHPEChSi1GEBMzg3oGo6_Lnw@mail.gmail.com>
Message-ID: <567006C4.8050906@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/15 19:16, Fabio Estevam wrote:
> On Tue, Dec 15, 2015 at 6:52 AM, Shawn Guo <shawnguo@kernel.org> wrote:
>> On Mon, Dec 14, 2015 at 11:07:50AM +0800, Shawn Guo wrote:
>>> On Wed, Dec 09, 2015 at 04:15:55PM +0800, Bai Ping wrote:
>>>> The 'assigned-clock-parents' and 'assigned-clock-rates' list
>>>> should corresponding to the 'assigned-clocks' property clock list.
>>>>
>>>> Signed-off-by: Bai Ping <b51503@freescale.com>
>>> Applied, thanks.
>> As this essentially a fix to ed339363de1b ("ARM: dts: imx6qdl-sabreauto:
>> Allow HDMI and LVDS to work simultaneously"), I'm going to send it as a
>> fix with copying stable.
> Actually the mismatch exists since 97dae8590fa314c ("ARM: dts:
> imx6qdl-sabreauto: Add audio support").
>
>> @Fabio,
>>
>> Do you agree with the fix?
> It seems that even after this patch we still have a mismatch:
> assigned-clocks has 5 members and assigned-clock-parents has 4.
I think if it is the last clock in the assigned-clock list, the 
corresponding
'assigned-clock-parents' and 'assigned-clock-rates'  entry can be omitted.

BR
Jacky Bai
