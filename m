From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 26 May 2014 18:58:00 +0200
Subject: [PATCH v2 5/5] regulator: axp20x: resolve self dependency issue
In-Reply-To: <20140526154356.GZ22111@sirena.org.uk>
References: <1401116292-24066-1-git-send-email-boris.brezillon@free-electrons.com>
 <1401116292-24066-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140526154356.GZ22111@sirena.org.uk>
Message-ID: <53837298.5080705@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 26/05/2014 17:43, Mark Brown wrote:
> On Mon, May 26, 2014 at 04:58:12PM +0200, Boris BREZILLON wrote:
>> Some regulators might take their power supply from other regulators defined
>> by the same PMIC.
>>
>> Retry regulators registration until all regulators are registered or the
>> last iteration didn't manage to register any new regulator (which means
>> there's an external dependency missing and we can thus return
>> EPROBE_DEFER).
> This is going to apply to most PMICs - we should factor this out into
> the core rather than implementing it individual drivers.  It works
> normally because typically the dependency is from DCDCs to LDOs and so
> with common naming schemes alphabetic sorting saves us.

I'm not sure I get what you mean.

AFAIU, we could factorize it by the mean of an helper function (say
devm_regulators_register), which would take a matches table and a
regulator desc table and do pretty much what I'm doing in this patch.

Is that what you had in mind ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
