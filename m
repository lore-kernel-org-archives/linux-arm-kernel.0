From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 01:02:47 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <51B7A325.8070108@gmail.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130611215023.GA12649@obsidianresearch.com> <51B7A325.8070108@gmail.com>
Message-ID: <2340087.iMJUFH7E1a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013 00:22:29 Sebastian Hesselbarth wrote:
> 
> When removing size from marvell,mbus-target above, mbus driver could
> also probe for required max size from the reg properties of the child
> nodes. Arnd already said that mbus isn't "simple-bus" anymore, why
> can't it just walk through the nodes and collect required windows?

It would work, but feels wrong to me. The 'reg' properties of each
device behind mbus would end up as software defined and need to
be updated for any change to the mapping, whether that change is
board specific or even at run-time. It would be even harder to
do dynamic assignment when you cannot put a proper address into
'reg'.

	Arnd
