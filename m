From: horia.geanta@nxp.com (Horia Geanta)
Date: Thu, 11 Oct 2018 10:04:31 +0000
Subject: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
 <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
 <1dd3074eabb496155c4d1abb83c82c52529a656a.camel@buserror.net>
Message-ID: <VI1PR0402MB34852BFA7E8E44E9B867D76F98E10@VI1PR0402MB3485.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/29/2018 3:31 AM, Scott Wood wrote:
> On Tue, 2018-08-21 at 15:45 -0500, Rob Herring wrote:
>> On Mon, Aug 20, 2018 at 1:52 PM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>>> +/ {
>>> +       model = "NXP Layerscape LX2160ARDB";
>>> +       compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
>>> +
>>> +       aliases {
>>> +               crypto = &crypto;
>>
>> Drop this. Aliases should be numbered, and this is not a standard
>> alias name either.
> 
> Is this a new rule?  In any case, U-Boot looks for a "crypto" alias.
> 
(Replying here, I did not see a follow-up).

Indeed, U-boot relies on the "crypto" alias.
This is true for all SoCs with CAAM crypto engine, a pretty lengthy list.

Could you please clarify?
Also: Is numbering needed even when there is a single instance of the block?

Looking at a recent discussion
https://lore.kernel.org/patchwork/patch/991718
I see the proposal is for the ID to be optional:
> Alias names are often suffixed with a numeric ID, especially when there may
> be multiple instances of the same type. The ID typically corresponds to the
[...]

Thanks,
Horia
