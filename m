From: ananaza@iki.fi (Antti P Miettinen)
Date: Mon, 17 Mar 2014 13:15:07 +0200 (EET)
Subject: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1392724051-11950-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140317.131507.1338341364843764791.apm@brigitte.kvy.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for having been lazy in commenting..

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Tue, 18 Feb 2014 11:47:31 +0000
> +	- min-residency
> +		Usage: Required
> +		Value type: <prop-encoded-array>
> +		Definition: u32 value representing time in microseconds
> +			    required for the CPU to be in the idle state to
> +			    break even in power consumption terms compared
> +			    to idle state idle_standby ([4][5]).

To me this continues to be a bit illdefined. Say we have three states:
0,1,2. State 0 is the idle_standby. Providing a minimum residency for
state 1 compared to state 0 sort of makes sense, but if we provide a
minimum residency for state 2 compared to state 0 the break even time
is going to be smaller than break even when comparing state 1 and
state 2. With this data we'd enter state 2 when we'd be better off
entering state 1.

	--Antti
