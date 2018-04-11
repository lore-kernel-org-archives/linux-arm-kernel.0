From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 11 Apr 2018 10:09:47 +0530
Subject: [PATCH V7 00/13] drivers: Boot Constraint core
In-Reply-To: <1523367652.4981.9.camel@pengutronix.de>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
 <20180322012606.vuaemu3pvpeojtwr@vireshk-mac-ubuntu>
 <20180323150420.GA21152@kroah.com>
 <cbcfeb15-d940-f066-739d-25adfe09f019@linaro.org>
 <1523367652.4981.9.camel@pengutronix.de>
Message-ID: <20180411043947.GK7671@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-04-18, 15:40, Lucas Stach wrote:
> Can you please describe how this bootconstraints core integration is
> simpler than a "run things at max performance until late kernel init",
> which could be triggered by a simple initcall similar to what is done
> for clocks and regulators?
> 
> To me the bootcontraints stuff looks like a fairly complex solution and
> your use-case doesn't even sound like you strictly want to keep a
> bootloader configuration, but rather run things at max performance
> until you are reasonably sure that you got all the necessary bandwidth
> requests.

What about this case where drivers of some of the devices used during
boot are built as modules, like display, HDMI, etc., and would be
available only after userspace is up. We need to take care of their
bandwidth requirements as well, until the time their driver comes up.

-- 
viresh
