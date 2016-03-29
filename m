From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Mar 2016 12:38:57 +0100
Subject: [PATCH 0/4] drivers/bus: remove unused modular code from
 non-modular drivers
In-Reply-To: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
References: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20160329113856.GB6745@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2016 at 05:10:54PM -0400, Paul Gortmaker wrote:
> The drivers/bus doesn't have a strict maintainer entry, but since
> all the changes here are for ARM platforms, I'm Cc'ing arm-kernel
> and hoping it makes sense to vector these few changes through the
> arm-soc. [Olof, Will, Arnd? Seems you guys handle most of it...]

I plan to move the parts that are simply perf drivers under drivers/perf,
so that should remove some of the code from drivers/bus. There's a fiddly
part with the CCI, which has both perf code and bus initialisation code
that need prying apart.

Will
