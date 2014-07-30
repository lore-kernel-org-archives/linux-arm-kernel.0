From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 30 Jul 2014 10:49:25 +0200
Subject: [RFC 3/5] regulator: core: Only apply constraints if available
 on list voltage
In-Reply-To: <20140729171857.GV17528@sirena.org.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406651339-28901-4-git-send-email-javier.martinez@collabora.co.uk>
 <20140729171857.GV17528@sirena.org.uk>
Message-ID: <53D8B195.4050003@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark, thanks a lot for all your feedback.

On 07/29/2014 07:18 PM, Mark Brown wrote:
> On Tue, Jul 29, 2014 at 06:28:57PM +0200, Javier Martinez Canillas wrote:
>> 
>> But for load switches that don't define a voltage output, the parent
>> supply voltage is used so the constraints should only be applied if
>> they were defined for the child regulators.
> 
> No, think about what you're doing here and why we're filtering out
> unsettable voltages - this causes problems for consumers on regulators
> that don't have any ability to vary voltages since they will now be able
> to list voltages that they can't select.  
> 

Understood. Thanks for the explanation.

> I would also expect any regulator where the supplied devices are able to
> vary the voltage to explicitly provide a constraint even if the
> implementation is done in a parent regulator.  There may be constraints
> on the child supply which aren't directly present on the parent supply
> and can be ignored if the child supply is turned off.
> 

Agreed, if I explicitly set the voltage constraints on the child supply then
this patch is indeed not needed.

Best regards,
Javier
