From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Oct 2013 09:30:46 -0700
Subject: [PATCH v3 02/10] spmi: Linux driver framework for SPMI
In-Reply-To: <20131029155616.GG20207@joshc.qualcomm.com>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <149bbfe89e37376cc176c3aeb6c1fab9e4fd2b91.1382985169.git.joshc@codeaurora.org>
 <526FD278.8080102@metafoo.de> <20131029155616.GG20207@joshc.qualcomm.com>
Message-ID: <526FE2B6.8050701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/13 08:56, Josh Cartwright wrote:
>
>>> +#define to_spmi_controller(d) container_of(d, struct spmi_controller, dev)
>> Should be a inline function for better type safety.
> Sounds good.  Will change the to_spmi_*() macros.

I was under the impression that container_of() already does type
checking. At least it will ensure that typeof(d) == typeof(dev) in the
above example which is about as good as it can get.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
