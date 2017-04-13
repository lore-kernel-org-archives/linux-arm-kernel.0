From: bp@alien8.de (Borislav Petkov)
Date: Thu, 13 Apr 2017 22:47:45 +0200
Subject: [PATCH V14 02/10] ras: acpi/apei: cper: generic error data entry
 v3 per ACPI 6.1
In-Reply-To: <8a31ef45-68f6-d444-f174-4a485cccd696@codeaurora.org>
References: <1490729440-32591-1-git-send-email-tbaicar@codeaurora.org>
 <1490729440-32591-3-git-send-email-tbaicar@codeaurora.org>
 <20170412133447.n2yft7v266v6k6gh@pd.tnic>
 <8a31ef45-68f6-d444-f174-4a485cccd696@codeaurora.org>
Message-ID: <20170413204744.iizyyi32v4hjt3fc@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 02:30:21PM -0600, Baicar, Tyler wrote:
> I do not agree with this. The struct being passed to this function is
> already named acpi_hest_generic_data in the existing code and all over this
> code is named gdata not just d.

And I'm saying they're too long - the preexisting ones and the ones
you're adding - and impair readability. This whole driver is one
unreadable ugly pile and if I were the maintainer I would never allowed
it in its current form.

But I don't think it really has a maintainer - poor Rafael has to deal
with it because it is under drivers/acpi/ and that whole RAS firmware
crap got thrown over the wall at some point and now we're stuck with it.

So this is just my opinion since he asked me to take a look.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
