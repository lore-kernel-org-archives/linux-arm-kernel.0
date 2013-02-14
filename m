From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Feb 2013 10:54:28 -0700
Subject: [PATCH 1/1] ARM: dt: add header to define tegra20 clocks
In-Reply-To: <1360823899-17846-1-git-send-email-hdoyu@nvidia.com>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
 <1360823899-17846-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <511D24D4.6070805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2013 11:38 PM, Hiroshi Doyu wrote:
> To replace magic number in "clocks = <&tegra_car 28>;"

I like the concept here; I was thinking about doing this today, but you
beat me to it:-) Feel free to create the Tegra30 header too, and modify
all the *.dts* files.

To address other comments in this thread: Yes, I think that we will want
to modify the clock driver to include this header to avoid
duplication/errors (that will require adjusting Linux's include path),
and also remove the list of IDs from the binding document; it can just
refer the the new header by name and cause the header to *be* part of
the binding document.
