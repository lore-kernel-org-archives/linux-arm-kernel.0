From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 Jan 2015 21:16:30 +0100
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20150105131302.GB14967@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <54A28B22.7090305@linaro.org>
 <20150105131302.GB14967@e104818-lin.cambridge.arm.com>
Message-ID: <1797489.PjmKzBFdQA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 January 2015 13:13:02 Catalin Marinas wrote:
> 
> > since passing no DT tables to OS but
> > acpi=force is missing is a corner case, we can do a follow up patch to
> > fix that, does it make sense?
> 
> Not entirely. Why would no dtb and no acpi=force be a corner case? I
> thought this should be the default when only ACPI tables are passed, no
> need for an additional acpi=force argument.

We don't really support the case of only ACPI tables for now. The expectation
is that you always have working DT support, at least for the next few years
as ACPI features are ramping up, and without acpi=force it should not try
to use ACPI at all.

	Arnd
