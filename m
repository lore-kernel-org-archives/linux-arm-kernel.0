From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 24 Jun 2014 18:43:13 +0200
Subject: [PATCH v2 07/10] regulator: Add driver for Maxim 77802 PMIC
 regulators
In-Reply-To: <20140623094734.GV24291@sirena.org.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
 <20140616192500.GJ5099@sirena.org.uk> <53A01D54.10506@collabora.co.uk>
 <20140617141254.GP5099@sirena.org.uk> <53A06749.1010606@collabora.co.uk>
 <20140621204026.GH22657@sirena.org.uk> <53A7F339.7050608@collabora.co.uk>
 <20140623094734.GV24291@sirena.org.uk>
Message-ID: <53A9AAA1.4030005@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 06/23/2014 11:47 AM, Mark Brown wrote:
> On Mon, Jun 23, 2014 at 11:28:25AM +0200, Javier Martinez Canillas wrote:
>> On 06/21/2014 10:40 PM, Mark Brown wrote:
> 
>> > That's not really relevant here - I'm asking if the regulators get their
>> > own supplies rather than if anything uses them.
> 
>> Sorry if I keep misunderstanding your question but the regulators in this PMIC
>> don't have a parent supply/regulator node.
> 
> They should, I'm pretty sure the device does actually regulate one
> supply into another.
> 

Thanks a lot for the clarification. This was not evident to me when I read the
PMIC datasheet and because both the max77xxx Chrome OS 3.8 and mainline max77686
drivers used a simplistic model of the power scheme.

But Doug confirmed to me that some regulators on this PMIC do indeed use others
regulators as a power supply so I'll change this in the next version of the
patch-set.

Best regards,
Javier
