From: mikedunn@newsguy.com (Mike Dunn)
Date: Fri, 28 Dec 2012 13:04:59 -0800
Subject: [PATCH] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <50DDF7C3.40303@mvista.com>
References: <1356706349-3189-1-git-send-email-mikedunn@newsguy.com>
 <50DDF7C3.40303@mvista.com>
Message-ID: <50DE097B.5050201@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/2012 11:49 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/28/2012 05:52 PM, Mike Dunn wrote:
> 
>> This patch fixes some code that implements a work-around to a hardware bug in
>> the ac97 controller on the pxa27x.  A bug in the controller's warm reset
>> functionality requires that the mfp used by the controller as the AC97_RESET_n
>> line be temporarily reconfigured as a generic output gpio (AF0) and manually
>> held high for the duration of the warm reset cycle.  This is what was done in
>> the original code, but it was broken long ago by commit
>> fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6, which changed the mfp to a GPIO input
> 
>    Please also specify the summary of that commit in parens.


OK, will resend patch.

Thanks,
Mike
