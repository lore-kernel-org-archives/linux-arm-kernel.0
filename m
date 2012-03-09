From: Richard.Earnshaw@arm.com (Richard Earnshaw)
Date: Fri, 9 Mar 2012 17:38:38 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <alpine.LFD.2.02.1203091112050.24151@xanadu.home>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1330360043.8557.302.camel@zakaz.uk.xensource.com>
 <20120227180355.GB2023@linaro.org>
 <1330371219.10008.34.camel@dagon.hellion.org.uk>
 <20120228102040.GB2063@linaro.org>
 <1330426133.31269.70.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.00.1202281149210.23091@kaball-desktop>
 <20120229093436.GA2077@linaro.org>
 <1330509362.4270.20.camel@zakaz.uk.xensource.com>
 <20120229125826.GC2077@linaro.org>
 <alpine.LFD.2.02.1203021528150.31242@xanadu.home> <4F5882BF.1030104@arm.com>
 <alpine.LFD.2.02.1203081041340.24151@xanadu.home> <4F58FEC0.8080706@arm.com>
 <CA+wbFdfF5c+Bw6RrxCm3YThqCRDuDYzanq+HV8a6LyXaBqWrQA@mail.gmail.com>
 <alpine.LFD.2.02.1203091112050.24151@xanadu.home>
Message-ID: <4F5A401E.3070008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/12 16:20, Nicolas Pitre wrote:
> On Fri, 9 Mar 2012, Dave Martin wrote:
>
>> Register variables feel like a red herring though.  We're only using
>> those because we can't do the needful thing and actually desscribe
>> these constraints in the asm constraints (which would seem to be the
>> right place).  We specifically don't care where those values are
>> except at the boundaries of the asm block itself.
>
> Absolutely.
>
>> Is there a reason why ARM gcc doesn't provide the ability to specify
>> such exact-register constraints, or is this more for historical
>> reasons?  It is possible?
>
> I don't know how much things have changed since I last looked at the gcc
> code, but implementing this seemed to be pretty trivial at the time.
> The problem would be to determine a good letter scheme to map to actual
> registers.
>
>
> Nicolas
>

While it is technically possible, it is likely to end up hurting overall
compiler performance as we'll then have to define the machine as having
small register classes.

--
Richard Earnshaw             Email: Richard.Earnshaw at arm.com
Engineering Manager          Phone: +44 1223 400569 (Direct + VoiceMail)
OpenSource Tools             Switchboard: +44 1223 400400
ARM Ltd                      Fax: +44 1223 400410
110 Fulbourn Rd              Web: http://www.arm.com/
Cambridge, UK. CB1 9NJ

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
