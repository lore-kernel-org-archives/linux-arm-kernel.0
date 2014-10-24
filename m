From: balbi@ti.com (Felipe Balbi)
Date: Fri, 24 Oct 2014 10:43:12 -0500
Subject: [PATCH V3 3/3] rtc: omap: Support regulator supply for RTC
In-Reply-To: <544A5393.6090504@ti.com>
References: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
 <1414126425-13198-4-git-send-email-lokeshvutla@ti.com>
 <544A5393.6090504@ti.com>
Message-ID: <20141024154312.GL26941@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 08:26:43AM -0500, Nishanth Menon wrote:
> On 10/23/2014 11:53 PM, Lokesh Vutla wrote:
> > On some Soc's RTC is powered by an external power regulator.
> SoC ? -> could you rephrase this to indicate "certain SoCs such as
> DRA7, RTC is an independent voltage domain of it's own and on
> platforms such as DRA7-evm, this may be supplied by individual
> regulator on it's own.
> 
> > e.g. RTC on DRA7 SoC. Make the OMAP RTC driver support a
> > power regulator.
> 
> Question ofcourse is what voltage would you like that regulator to be
> at? As you are aware, certain LDOs and SMPS can drive varying voltage
> and just enable/disable would do just the default voltage of the
> SMPS/LDO, right? OR am i missing something here?

just pass the correct voltage through DTS as we do for all other
regulators ? It's only tricky when we have a range of acceptable
voltages but for RTC, IIRC, it's always a set voltage (1.0V or 1.8V).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141024/9f6a78a9/attachment.sig>
