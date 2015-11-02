From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 2 Nov 2015 18:33:22 +0100
Subject: [PATCH v8 2/2] arm-soc: Add support for arm-based tango4 platforms
In-Reply-To: <yw1xfv0o9xr3.fsf@unicorn.mansr.com>
References: <56377E76.2080209@sigmadesigns.com>
 <56377F09.6050805@sigmadesigns.com> <yw1xfv0o9xr3.fsf@unicorn.mansr.com>
Message-ID: <56379E62.4080704@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2015 17:22, M?ns Rullg?rd wrote:

> Unless I'm missing something, you should enable the SCU before starting
> secondary CPUs.  It's also a good idea to structure the code with
> separate prepare and boot functions even if all the current chips are
> only dual-core.

About the SCU: I will check with the firmware author.
About prepare: this is the firmware's responsibility.
(Not all chips are dual-core, the 8756 is single-core.)

> What about other registers?  Does the firmware support setting the
> prefetch control register?

Yes, after masking out some bits.
My port uses the firmware-supplied value.

Regards.
