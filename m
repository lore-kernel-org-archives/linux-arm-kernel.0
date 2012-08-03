From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Fri, 3 Aug 2012 10:52:09 -0500
Subject: [PATCH 2/3] ARM: OMAP: hwmod: revise deassert sequence
In-Reply-To: <501B609F.9030403@ti.com>
References: <1342466485-1050-1-git-send-email-omar.luna@linaro.org>
 <1342466485-1050-3-git-send-email-omar.luna@linaro.org>
 <alpine.DEB.2.00.1208020150240.4177@utopia.booyaka.com>
 <CALLhW=6-b+kjfG-u3+uXiD64UwoNEdufjJKu0Mx-sGWp6n9csg@mail.gmail.com>
 <501B609F.9030403@ti.com>
Message-ID: <CALLhW=7yJTq_cfB=KGY5VT8fNO1u_hrY118ysihFuQA+gVFRuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 August 2012 00:24, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> On 8/3/2012 3:50 AM, Omar Ramirez Luna wrote:
>> So in _enable:
>>
>>         _enable_clocks(oh);
>>         if (soc_ops.enable_module)
>>                 soc_ops.enable_module(oh);
>>
>> The enable_module part seems redundant to me, since the module should
>> be already enabled by the first call to _enable_clocks.
>
> Yes they do same thing, I believe the plan is to get rid of all clock
> leaf-nodes in the near future, and let hwmod handle module
> enable/disable part.

If this is the case then an enable_module call is needed in my patch
for when these changes are made. The original works fine but only
because currently clock framework does what enable_module is doing.

Paul,

Please let me know if you want me to resend with this change.

Regards,

Omar
