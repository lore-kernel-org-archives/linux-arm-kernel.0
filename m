From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 21 Oct 2015 09:55:43 +0800
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <20151020173639.GH31130@pd.tnic>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151019205236.GB453@leverpostej> <56266F7E.6030404@amd.com>
 <20151020165744.GE31130@pd.tnic> <20151020172654.GC4943@leverpostej>
 <20151020173639.GH31130@pd.tnic>
Message-ID: <5626F09F.4050107@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris, Mark,

On 2015/10/21 1:36, Borislav Petkov wrote:
> On Tue, Oct 20, 2015 at 06:26:55PM +0100, Mark Rutland wrote:
>>> Btw, how much of this is implementing generic A57 functionality?
>> The driver is entirely A57 generic.
>>
>>> If a lot, can we make this a generic a57_edac driver so that multiple
>>> vendors can use it?
>> Yes.
> Ok, cool.
>
>>> How fast and how ugly can something like that become?
>> Not sure I follow.
> In the sense that some vendor might require just a little bit different
> handling or maybe wants to read some vendor-specific registers in
> addition to the architectural ones.

Yes, you are right and foresight :)

>
> Then we'll start adding vendor-specific hacks to that generic driver.
> And therefore the question how fast and how ugly such hacks would
> become.
>
> I guess we'll worry about that when we get there...

So I think the meaning of those error register is the same, but the way
of handle it may different from SoCs, for single bit error:

 - SoC may trigger a interrupt;
 - SoC may just keep silent so we need to scan the registers using poll
   mechanism.

For Double bit error:
  - SoC may also keep silent
  - Trigger a interrupt
  - Trigger a SEI (system error)

Any suggestion to cover those cases?

Thanks
Hanjun
