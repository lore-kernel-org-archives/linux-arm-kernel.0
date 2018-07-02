From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 2 Jul 2018 07:32:01 +0530
Subject: [PATCH v2 3/3] dt-bindings: clock: Modify Actions Soc clock
 bindings
In-Reply-To: <88ce01d4-2694-eca0-770e-d4bd2869a258@suse.de>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-4-sravanhome@gmail.com>
 <20180630093202.GB7320@Mani-XPS-13-9360>
 <15070ea0-aebf-2b7d-89f0-b21e729c927e@gmail.com>
 <20180701173706.GA15895@Mani-XPS-13-9360>
 <88ce01d4-2694-eca0-770e-d4bd2869a258@suse.de>
Message-ID: <20180702020201.GA2654@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On Sun, Jul 01, 2018 at 07:58:15PM +0200, Andreas F?rber wrote:
> Hi,
> 
> Am 01.07.2018 um 19:37 schrieb Manivannan Sadhasivam:
> > On Sun, Jul 01, 2018 at 07:26:20PM +0200, Saravanan Sekar wrote:
> >> Hi Mani
> >>
> >>
> >> On 06/30/18 11:32, Manivannan Sadhasivam wrote:
> >>> Hi Saravanan,
> >>>
> >>> I agree with modifying the existing binding to accomodate other
> >>> SoC's of the same family. But the binding should be
> >>> "actions,owl-cmu.txt" since it reflects the family name.
> >>
> >> Agree, will modify the name
> >>
> >>> Andreas, what do you think?
> 
> I concur that sx00 is insufficient. Older models were called ATMxxxx.
> Unfortunately with owl- it then no longer matches the compatible, but I
> wouldn't mind.
> 
> >>> On Thu, Jun 28, 2018 at 09:18:05PM +0200, Saravanan Sekar wrote:
> >>>> Modify clock bindings common Actions Semi Soc family S700/S900.
> >>>>
> >>>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> >>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> >>>> ---
> >>>>   ...tions,s900-cmu.txt => actions,sx00-cmu.txt} | 18 ++++++++++--------
> >>>>   1 file changed, 10 insertions(+), 8 deletions(-)
> >>>>   rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> >>>> similarity index 71%
> >>>> rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> >>>> rename to Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> >>>> index 93e4fb827cd6..8dc7edb4d198 100644
> >>>> --- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> >>>> +++ b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> >>>> @@ -1,12 +1,14 @@
> >>>> -* Actions S900 Clock Management Unit (CMU)
> >>>> +* Actions S900/S700 Clock Management Unit (CMU)
> >>> Same as above. Should be Actions OWL SoC's Clock Management Unit (CMU).
> >>
> >> sure
> >>
> > 
> > During the review of I2C controller driver, Andreas pointed out that
> > we should use Owl instead of OWL in all places and also Actions should
> > be replaced by Actions Semiconductor.
> 
> Actually I was just asking to include the company name and not just say
> Owl. Whether it's Actions, Actions Semi or Actions Semiconductor is not
> that important to me - that would be for the Actions Semi colleagues to
> comment - which I see are not in CC... Please fix that! You don't need
> mp-cs I think, but the others please.
> 

Okay, cool.

> > So, please change it in relevant
> > places. For this binding, title should be:
> > 
> > Actions Semiconductor Owl SoC's Clock Management Unit (CMU).
> 
> "SoC's" looks weird there, do we have such precedence to add it?
> "Actions Owl Clock Management Unit (CMU)" might do?
> 

Let's keep 'Actions Semi' everywhere unless Actions Semi people say
differently.

> Saravanan, please compare other patch titles and adapt your subjects
> accordingly: "modify bindings" is not very meaningful, since a patch
> always modifies something and the prefix already indicates dt-bindings
> as target. "Soc" is misspelled. The time-saving information to put there
> would be addition of S700.
> 
> >>>> -The Actions S900 clock management unit generates and supplies clock to various
> >>>> -controllers within the SoC. The clock binding described here is applicable to
> >>>> -S900 SoC.
> >>>> +The Actions S900/S700 clock management unit generates and supplies clock to
> >>>> +various controllers within the SoC. The clock binding described here is
> >>>> +applicable to S900/S700 SoC.
> 
> "S900 and S700 SoCs"? (keep the slash above)
> 

Agree.

> >>>>   Required Properties:
> >>>> -- compatible: should be "actions,s900-cmu"
> >>>> +- compatible: should be one of this
> >>> Change to: compatible: should be one of the following:
> >>
> >> sure
> >>
> >>> Thanks,
> >>> Mani
> >>>
> >>>> +	"actions,s900-cmu"
> >>>> +	"actions,s700-cmu"
> 
> Mani, should we order alphabetically? I.e., will S500 go before S900, or
> will people just always append at the end now? Not saying we have to,
> but keeping it consistent across Actions bindings would be desirable.
> 

Yes, we should order alphabetically IMO. That way it looks good!

> >>>>   - reg: physical base address of the controller and length of memory mapped
> >>>>     region.
> >>>>   - clocks: Reference to the parent clocks ("hosc", "losc")
> >>>> @@ -15,9 +17,9 @@ Required Properties:
> >>>>   Each clock is assigned an identifier, and client nodes can use this identifier
> >>>>   to specify the clock which they consume.
> >>>> -All available clocks are defined as preprocessor macros in
> >>>> -dt-bindings/clock/actions,s900-cmu.h header and can be used in device
> >>>> -tree sources.
> >>>> +All available clocks are defined as preprocessor macros in corresponding
> >>>> +dt-bindings/clock/actions,s900-cmu.h or s700-cmu.h header and can be used in
> 
> actions,s700-cmu.h for humans please or at least ...,s700-cmu.h.
> 

actions,s700-cmu.h looks good to me.

Thanks,
Mani

> >>>> +device tree sources.
> >>>>   External clocks:
> 
> Thanks,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
