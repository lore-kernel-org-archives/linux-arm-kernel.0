From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Sep 2011 09:11:40 +0100
Subject: [PATCH 1/3] arm/tegra: Move EN_VDD_1V05_GPIO to board-harmony.h
In-Reply-To: <CAOesGMisOtEQpcS-hHi-3brpYzJr-UiB6b71c+bwkesPDk9iuA@mail.gmail.com>
References: <1316633620-13184-1-git-send-email-swarren@nvidia.com>
	<CAOesGMisOtEQpcS-hHi-3brpYzJr-UiB6b71c+bwkesPDk9iuA@mail.gmail.com>
Message-ID: <20110922081140.GH17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 01:16:49PM -0700, Olof Johansson wrote:
> Works for me. Or I could stage it in a topic branch that would be
> merged after Russell's GPIO tree.

Holding stuff off from being merged doesn't work.  If you have the
following commit structure:

A---...-----M1-B-C-M2
+---A1-B1-C1'     /
+-A2-B2-C2-------'

Now, lets say A2 depends on C1.  Merely delaying the stuff so that M2
happens after M1 is insufficient to ensure git state doesn't break.
When bisecting, its entirely possible that the bisect algorithm may
chose B2 as a potential test candidate.  At that point you end up with
A2, but without C1.

The only way to solve this is to have A2 following on from C1 - which
of course requires A1..C1 to be declared stable and either pulled into
your local tree or for A2..C2 to be submitted to the same tree which
A1..C1 are already in.
