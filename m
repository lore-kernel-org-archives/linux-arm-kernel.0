From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Feb 2012 16:55:25 -0600
Subject: [PATCH v2 03/28] ARM: imx: convert to common runtime ioremap hook
In-Reply-To: <201202292134.03220.arnd@arndb.de>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <1330547147-22867-4-git-send-email-robherring2@gmail.com>
 <201202292134.03220.arnd@arndb.de>
Message-ID: <4F4EACDD.4090502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2012 03:34 PM, Arnd Bergmann wrote:
> On Wednesday 29 February 2012, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Convert i.MX platforms to use the common run-time ioremap hook instead of
>> the imx specific hook.
>>
>> Also, move addr_in_module out of io.h.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> 
> I wonder if we can't just get rid of imx3_ioremap if we put all the
> i.mx3 mappings below 0x80000000 into the static mapping area so that
> the new generic ioremap will just point to that.
> 

Sure, but it's not my call what the i.MX guys do. I'm just generalizing
what i.MX already has for other platforms to use. Since we have no way
to create static mappings from devicetrees I don't think we want to
expand static mappings. Also, your past guidance has been to get rid of
static mappings.

Even if we got rid of it here and on msm, there are still other
platforms that need custom ioremap where static mappings won't help.
ebsa110 and ixp4xx also need ioremap but I didn't convert them to
runtime from compile time since they still need io.h for other reasons
at this point.

Rob
