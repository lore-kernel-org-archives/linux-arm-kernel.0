From: zonque@gmail.com (Daniel Mack)
Date: Fri, 23 Aug 2013 18:30:24 +0200
Subject: [PATCH v4 3/5] net: ethernet: cpsw: introduce ti,am3352-cpsw
 compatible string
In-Reply-To: <52177052.1030308@ti.com>
References: <1377267365-24057-1-git-send-email-zonque@gmail.com>
 <1377267365-24057-4-git-send-email-zonque@gmail.com>
 <52177052.1030308@ti.com>
Message-ID: <52178E20.5040404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.08.2013 16:23, Santosh Shilimkar wrote:
> On Friday 23 August 2013 10:16 AM, Daniel Mack wrote:

>> +static const struct of_device_id cpsw_of_mtable[] = {
>> +	{
>> +		.compatible	= "ti,am3352-cpsw",
>
> I didn't notice this earlier, but can't you use the IP version
> as a compatible instead of using a SOC name. Whats really SOC specific
> on this IP ? Sorry i have missed any earlier discussion on this but
> this approach doesn't seem good. Its like adding SOC checks in the
> driver subsystem.

As I already mentioned in the cover letter and in the commit message, I
just don't know which criteria makes most sense here.

On a general note, I would say that chances that this exactly IP core
with the same version number will appear on some other silicon which
doesn't support the control mode register in an AM33xx fashion, is not
necessarily negligible.

So what that new compatible string denotes is the cpsw in a version as
found on am3352 SoCs, which is actually exactly what it does.

I don't have a strong opinion here, but see your point. I just don't
have a better idea on how to treat that.


Daniel
