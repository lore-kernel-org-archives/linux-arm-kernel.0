From: timur@tabi.org (Timur Tabi)
Date: Mon, 26 Oct 2015 10:31:07 -0500
Subject: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
In-Reply-To: <562E447E.6070703@arm.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org> <562DF96D.6020307@arm.com>
 <562E20B2.4050805@codeaurora.org> <562E3213.8070602@arm.com>
 <562E33AE.2020608@codeaurora.org> <562E3BCF.7010000@arm.com>
 <562E3D02.2040108@codeaurora.org> <562E447E.6070703@arm.com>
Message-ID: <562E473B.6070504@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2015 10:19 AM, Andre Przywara wrote:

>> We have an internal patch that I'm trying to upstream, but I need the
>> amba-pl011 driver to stabilize first.
>
> As mentioned earlier, this looks like the perfect opportunity now to get
> the change in (since I see it as a subset of Jun's series). "Waiting for
> stabilization" sounds a bit optimistic to me in a general Linux context ;-)

I will post it today.

>> We use ACPI bindings.  It's our ARM64 server-class SOC.  We use the ACPI
>> subtype 13 to identify it.
>
> Does "subtype 13" refer to the UUID field here? So instead of using UUID
> 0 you have some vendor specific field set in your ARMH0011 table? Is
> that "just made up" or specified somewhere so that there will be no
> other usage of that number later?

It's part of the ARMH0011 table.  There are already a couple subtypes, 
but a bunch more were added.  It's table 3 in this document: 
http://go.microsoft.com/fwlink/p/?linkid=403551

Notice how the new subtype is already deprecated.  That's because it's 
technically a bug for hardware to require 32-bit accesses.
