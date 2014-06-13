From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 13 Jun 2014 14:30:29 +0100
Subject: [STLinux Kernel] Latest mainline (3.16 merge window) does not
 boot in B2020/STiH416
In-Reply-To: <20140613131051.GA28309@griffinp-ThinkPad-X1-Carbon-2nd>
References: <539AF5B0.6060509@linaro.org>
 <20140613131051.GA28309@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <539AFCF5.90206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/14 14:10, Peter Griffin wrote:
> Hi Daniel,
> 
> On Fri, 13 Jun 2014, Daniel Thompson wrote:
>> Hi Folks
>>
>> Using the lastest Linus T. mainline it is no longer possible to boot a
>> B2020/STiH416.
>>
>> The kernel boots OK and issues UART messages, but the system gets stuck
>> trying to mount the NFS root filesystem.
> 
> Are you booting with  clk_ignore_unused kernel parameter?
> 
> Its about at the point you describe that the unused clocks are disabled.

Thanks Pete. Adding this parameter fixes the problem.

Any idea why?

I only ask because there's very little related to the clocks in the
patch bisect picked up (and I did manually check the predecessor before
posting).


Daniel.
