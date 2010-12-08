From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 8 Dec 2010 10:30:53 +0000
Subject: RFC: Dynamic hwcaps
In-Reply-To: <4CFEA3FE.8090907@fluff.org>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
	<4CFEA3FE.8090907@fluff.org>
Message-ID: <AANLkTimmkZ56_Om8gowTHfg9x+0PUwsx7XysJvMTGxL1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 7, 2010 at 9:15 PM, Ben Dooks <ben-linux@fluff.org> wrote:

[...]

>
> Could you do what the original FP did, and start with units off and use
> the first use of $unit in the process to turn it on? Do things like NEON
> support this?
>

Actually, this is still done -- it's the same code since NEON and VFP
use a common register file.  The issue under discussion is that
userspace can't detect whether units like these are active or not, and
so can't make dynamic runtime decisions about whether to run
accelerated code or not. (And also, whether this would actually be
usefuil)

Cheers
---Dave
